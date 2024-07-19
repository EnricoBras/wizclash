//
//  WizardGameApp.swift
//  WizardGame
//
//  Created by Enrico Brasiello on 10/07/24.
//

import SwiftUI
import CoreMotion
import WatchConnectivity

@main
struct WizardGameApp: App {
    @StateObject private var motionManager = MotionManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(motionManager)
        }
    }
}

class MotionManager: NSObject, ObservableObject, WCSessionDelegate {
    private var session: WCSession

    @Published var accelerationData: [(timestamp: TimeInterval, x: Double, y: Double, z: Double)] = []
    @Published var movementHistory: [(movementType: String, accuracy: Double, timestamp: Date)] = []
    
    weak var delegate: MotionManagerDelegate?

    override init() {
        self.session = WCSession.default
        super.init()
        self.session.delegate = self
        self.session.activate()
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let timestamp = message["timestamp"] as? TimeInterval,
           let x = message["accelerationX"] as? Double,
           let y = message["accelerationY"] as? Double,
           let z = message["accelerationZ"] as? Double {
            let data = (timestamp: timestamp, x: x, y: y, z: z)
            DispatchQueue.main.async {
                self.accelerationData.append(data)
            }
        }

        if let movementType = message["movementType"] as? String, let accuracy = message["accuracy"] as? Double {
            if let delegate = delegate {
                let spell = (movementType: movementType, accuracy: accuracy)
                delegate.receivedSpell(self, spell: spell)
            }
            DispatchQueue.main.async {
                self.movementHistory.append((movementType: movementType, accuracy: accuracy, timestamp: Date()))
            }
        }
    }

    // Implementazione dei metodi WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activated")
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session became inactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("Session deactivated")
        self.session.activate()
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        print("Session reachability changed: \(session.isReachable)")
    }
}


protocol MotionManagerDelegate: AnyObject {
    func receivedSpell(_ manager: MotionManager, spell: (movementType: String, accuracy: Double))
}
