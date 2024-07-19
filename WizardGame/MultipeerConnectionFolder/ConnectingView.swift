//
//  ContentView.swift
//  MultipeerExample
//
//  Created by Luigi gallo on 01/07/24.
//

import SwiftUI

struct ConnectingView: View {
    @State private var username: String = "No user connected"
    @State private var isConnected: Bool = false
    @State private var connectionColor: Color = .red
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let mpcManager = MPCManager.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(connectionColor)
                        .frame(width: 50)
                        .padding()
                    Text(username)
                }
                
                Spacer()
                
                if isConnected {
                    Text("Connection success with \(username)")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()
                    
                    
                    
                    
                } else {
                    Button(action: {
                        mpcManager.startBrowsingService()
                        mpcManager.startAdvertiserService()
                    }, label: {
                        Text("Connect")
                            .padding(15)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    })
                }
                
                NavigationLink(destination: GameMultiplayerView(),isActive : $isConnected) {
                    Text("")
                
                }
                .hidden()
                .padding()
                .onReceive(timer) { _ in
                    isConnected = mpcManager.isConnected
                    if isConnected {
                        username = mpcManager.connectedPeer
                        connectionColor = .green
                    } else {
                        username = "No user connected"
                        connectionColor = .red
                    }
                }
                .navigationTitle("Connecting")
            }
        }
    }
    
    struct ConnectingView_Previews: PreviewProvider {
        static var previews: some View {
            ConnectingView()
        }
    }
}

#Preview{
    ConnectingView()
        .environmentObject(MotionManager())
}
