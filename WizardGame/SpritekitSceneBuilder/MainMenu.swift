//
//  MainMenu.swift
//  CodeNameWizard
//
//  Created by Enrico Brasiello on 24/06/24.
//
import Foundation
import SpriteKit
class MainMenu: SKScene {
    override func didMove(to view: SKView) {
       
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesArray = self.nodes(at: location)

        if nodesArray.first(where: { $0.name == "newGameButton" }) != nil {
            let transition = SKTransition.fade(withDuration: 0.5)
            let gameScene = GameplayScene(size: self.size)
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
}
