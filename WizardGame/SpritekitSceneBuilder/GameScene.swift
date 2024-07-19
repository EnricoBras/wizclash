//
//  GameScene.swift
//  Wiz Clash
//
//  Created by raffaele on 26/06/24.
//
import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        // Configurazione iniziale della scena
        // Imposta il background
        let background = SKSpriteNode(imageNamed: "backgroundImage")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        // Aggiungi altri elementi come terreno e personaggi
        let ground = SKSpriteNode(imageNamed: "groundImage")
        ground.position = CGPoint(x: size.width / 2, y: size.height * 0.1)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        addChild(ground)

        let character1 = SKSpriteNode(imageNamed: "character1Image")
        character1.position = CGPoint(x: size.width * 0.3, y: size.height * 0.2)
        character1.physicsBody = SKPhysicsBody(rectangleOf: character1.size)
        addChild(character1)
        
        let character2 = SKSpriteNode(imageNamed: "character2Image")
        character2.position = CGPoint(x: size.width * 0.7, y: size.height * 0.2)
        character2.physicsBody = SKPhysicsBody(rectangleOf: character2.size)
        addChild(character2)
    }
}
