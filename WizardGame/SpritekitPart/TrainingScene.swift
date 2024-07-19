import SpriteKit

class TrainingScene: SKScene, MotionManagerDelegate {
    var castedMagic: SKSpriteNode! // Dichiarazione della variabile di istanza
    var magicLabel: SKLabelNode! // Dichiarazione della variabile di istanza per la label
    var magicFrame: SKShapeNode! // Dichiarazione della variabile di istanza per il riquadro
    var motionManager: MotionManager?
    
    override func didMove(to view: SKView) {
        motionManager?.delegate = self
        
        // Impostiamo il background
        let background = SKSpriteNode(imageNamed: "Schermata")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let scaleX = frame.size.width / background.size.width
        let scaleY = frame.size.height / background.size.height
        let scale = max(scaleX, scaleY)
        background.setScale(scale)
        background.zPosition = 1
        addChild(background)
        
        // Configurare il riquadro per incorniciare l'immagine della magia e la label
        let frameWidth: CGFloat = 300
        let frameHeight: CGFloat = 350
        magicFrame = SKShapeNode(rectOf: CGSize(width: frameWidth, height: frameHeight), cornerRadius: 20)
        magicFrame.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        magicFrame.fillColor = .white
        magicFrame.strokeColor = .black
        magicFrame.lineWidth = 4
        magicFrame.zPosition = 2
        addChild(magicFrame)
        
        // Aggiungi nodi immagine per rappresentare la magia lanciata
        castedMagic = SKSpriteNode(imageNamed: "Spell?")
        castedMagic.name = "castedMagic"
        castedMagic.position = CGPoint(x: 0, y: 50) // Posizione relativa al riquadro
        castedMagic.size = CGSize(width: 240, height: 240) // Imposta la dimensione dell'immagine
        castedMagic.zPosition = 3
        magicFrame.addChild(castedMagic)
        
        // Configurare la label per mostrare il nome della magia
        magicLabel = SKLabelNode(fontNamed: "Helvetica")
        magicLabel.fontSize = 24
        magicLabel.fontColor = .black
        magicLabel.position = CGPoint(x: 0, y: -frameHeight / 2 + 50) // Posizione relativa al riquadro
        magicLabel.zPosition = 3
        magicLabel.text = "Unknown Spell"
        magicFrame.addChild(magicLabel)
    }
    
    func recognizeMagic(magic: String) -> Int {
        switch magic {
        case "fireball": return 0
        case "heal": return 1
        case "blizzard": return 2
        case "lightning" : return 3
        default: return 0
        }
    }

    func updateMagicCasted(node: SKSpriteNode, name: String) {
        var imageName = "null"
        
        switch name {
        case "fireball":
            imageName = "fireImage"
        case "heal":
            imageName = "healImage"
        case "blizzard":
            imageName = "freezeImage"
        case "lightning":
            imageName = "lightningImage"
        default:
            imageName = "Spell?"
        }
        
        node.texture = SKTexture(imageNamed: imageName)
    }
    
    func receivedSpell(_ manager: MotionManager, spell: (movementType: String, accuracy: Double)) {
        print(spell.movementType)
        updateMagicCasted(node: castedMagic, name: spell.movementType)
        updateMagicLabel(name: spell.movementType)
    }
    
    func updateMagicLabel(name: String) {
        magicLabel.text = name.capitalized
    }
}
