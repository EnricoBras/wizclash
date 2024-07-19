import SwiftUI
import SpriteKit

struct GameView: View {
    @EnvironmentObject var motionManager: MotionManager

    var scene: SKScene {
        let scene = GamingSceneInitz(size: CGSize(width: 750, height: 1334))
        scene.scaleMode = .resizeFill
        scene.motionManager = motionManager
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        GameView()
            .environmentObject(MotionManager())
    }
}
