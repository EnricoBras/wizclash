//
//  GameMultiplayerView.swift
//  CodeNameWizard
//
//  Created by Enrico Brasiello on 10/07/24.
//

import SwiftUI
import SpriteKit

struct GameMultiplayerView: View {
    @EnvironmentObject var motionManager: MotionManager
    
    
    var scene: SKScene {
        let scene = GamingSceneMultiplayerFile(size: CGSize(width: 750, height: 1334))
        scene.motionManager = motionManager
        scene.scaleMode = .resizeFill
            
        return scene
        
}
        
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameMultiplayerView()
        .environmentObject(MotionManager())
}
