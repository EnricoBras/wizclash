//
//  MPCManager.swift
//  MultipeerExample
//
//  Created by Luigi gallo on 01/07/24.
//

import Foundation
import MultipeerConnectivity

class MPCManager: NSObject {
    static let shared: MPCManager = MPCManager()
    
    private let peerID: MCPeerID = MCPeerID(displayName: UIDevice.current.name)
    private let session: MCSession
     
    private lazy var browser: MCNearbyServiceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: "random-message")
    private lazy var advertiser: MCNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "random-message")
    
    var receivedMessage: Message?
    var isConnected: Bool = false
    var connectedPeer: String = ""
    var isHost: Bool = false
    weak var delegate: MPCManagerDelegate?
    
    private override init() {
        self.session = MCSession(peer: peerID)
        super.init()
        
        session.delegate = self
        browser.delegate = self
        advertiser.delegate = self
    }
    
    func startBrowsingService() {
        isHost = false
        browser.startBrowsingForPeers()
    }
    
    func stopBrowsingService() {
        browser.stopBrowsingForPeers()
    }
    
    func startAdvertiserService() {
        isHost = true
        advertiser.startAdvertisingPeer()
    }
    
    func stopAdvertiserService() {
        advertiser.stopAdvertisingPeer()
    }
    
    deinit {
        stopBrowsingService()
        stopAdvertiserService()
    }
    
    func send(message: Message) {
        if let data = message.toData() {
            try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
    }
}

extension MPCManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        var stringState: String = ""
        
        switch state {
        case .connected:
            stringState = "Connected"
            isConnected = true
            connectedPeer = peerID.displayName
            if let delegate = delegate {
                delegate.isPlayerConnected(self, playerName: peerID.displayName)
            }
            
        case .connecting:
            stringState = "Connecting"
            isConnected = false
            connectedPeer = ""
        case .notConnected:
            stringState = "Not Connected"
            isConnected = false
            connectedPeer = ""
        @unknown default:
            fatalError("State not recognized: \(state)")
        }
        print("\(peerID.displayName): \(stringState)")
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let message = Message.toMessage(from: data) {
            receivedMessage = message
            if let delegate = delegate{
                delegate.receiveMessage(self, message: message)
            }
        } else {
            receivedMessage = nil
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) { }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) { }
}

extension MPCManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
        print("A Peer is found \(peerID.displayName)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) { }
}

extension MPCManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, self.session)
    }
}

protocol MPCManagerDelegate: AnyObject {
    func receiveMessage(_ mpcManager: MPCManager, message: Message)
    func isPlayerConnected(_ mpcManager: MPCManager, playerName: String)
}
