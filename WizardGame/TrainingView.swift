//
//  TrainingView.swift
//  WizardGame
//
//  Created by Enrico Brasiello on 14/07/24.
//
import SwiftUI
import SpriteKit

struct TrainingView: View {
    @EnvironmentObject var motionManager: MotionManager

    var scene: SKScene {
        let scene = TrainingScene(size: CGSize(width: 750, height: 1334))
        scene.scaleMode = .resizeFill
        scene.motionManager = motionManager
        return scene
}
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

#Preview {
    TrainingView()
        .environmentObject(MotionManager())
}
