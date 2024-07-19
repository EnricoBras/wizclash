import SpriteKit

class TextureCacheSingle {
    static let shared = TextureCache()
    let life6 = SKTexture(imageNamed: "life6")
    let life4 = SKTexture(imageNamed: "life4")
    let life1 = SKTexture(imageNamed: "life1")
    let life0 = SKTexture(imageNamed: "life0")
}

class GamingSceneInitz: SKScene, MotionManagerDelegate {
    var player1: PlayerStructureData!
    var player2: PlayerStructureData!
    
    var isGameEnded : Bool = false
    var timerLabel: SKLabelNode!
    var aiTimer: Timer?
    var turnDuration: TimeInterval = 30
    var aiActionInterval: TimeInterval = 6
    var gameTimer: TimeInterval = 30 // Timer per l'intera partita
    var manaRegenTimer: Timer?
    
    
    var player1Points : Int = 0
    var player2Points : Int = 0
    
    var player1HealthNode: SKSpriteNode!
    var player2HealthNode: SKSpriteNode!
    var player1ManaNode: SKSpriteNode!
    var player2ManaNode: SKSpriteNode!
    var player1ManaLabel: SKLabelNode!
    var player2ManaLabel: SKLabelNode!
    var player1WizardIdle: SKSpriteNode!
    var player2WizardIdle: SKSpriteNode!
    var motionManager: MotionManager?
    
    let wizardIdle = SKSpriteNode(imageNamed: "idle1")
    let wizardAttack = SKSpriteNode(imageNamed: "f1")
    let wizardDie = SKSpriteNode(imageNamed: "die1")
    let fireballSprite = SKSpriteNode(imageNamed: "fireball1")
    
    private var fire = SKSpriteNode()
    private var fireWalkingFrames: [SKTexture] = []
    
    func recognizeMagic(magic: String) -> Int {
        switch magic {
        case "fireball": return 0
        case "heal": return 1
        case "blizzard": return 2
        case "lightning" : return 3
        default: return 0
        }
    }
    
    func receivedSpell(_ manager: MotionManager, spell: (movementType: String, accuracy: Double)) {
        print("Received spell: \(spell.movementType)")
        let index = recognizeMagic(magic: spell.movementType)
        applyMagic(whoIsDoing: player1, selectedPlayer: player2, magic: magicBook[index])
        updateLabels()
    }
    
    override func didMove(to view: SKView) {
        player1 = PlayerStructureData()
        player2 = PlayerStructureData()
        isGameEnded = false  // Inizia la partita con isGameEnded impostato su false
        
        if let motionManager = motionManager {
            motionManager.delegate = self
        } else {
            print("motionManager is not initialized")
        }
        setupScene()
        startTurnTimer()
        startGameTimer()
    }
    
    func setupScene() {
        // Se il gioco non è terminato, aggiungi gli elementi alla scena
        if !isGameEnded {
            timerLabel = SKLabelNode(text: "Time: \(Int(turnDuration))")
            timerLabel.name = "timerLabel"
            timerLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
            timerLabel.zPosition = 40
            addChild(timerLabel)
            
            // Aggiungi pulsanti per le magie
            /*for (index, magic) in magicBook.enumerated() {
                let button = SKLabelNode(text: magic.text)
                button.name = "magicButton\(index)"
                button.position = CGPoint(x: size.width * 0.5, y: size.height * (0.8 - CGFloat(index) * 0.1))
                button.zPosition = 10 // Assicurati che i pulsanti siano in primo piano
                addChild(button)
            }*/
        }
        
        // Impostiamo il background
        let background = SKSpriteNode(imageNamed: "\(selected)")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let scaleX = frame.size.width / background.size.width
        let scaleY = frame.size.height / background.size.height
        let scale = max(scaleX, scaleY)
        background.setScale(scale)
        background.zPosition = 1
        addChild(background)
        
        // Aggiungi nodi immagine per rappresentare la salute
        player1HealthNode = SKSpriteNode(imageNamed: "life6")
        player1HealthNode.name = "player1HealthNode"
        player1HealthNode.position = CGPoint(x: size.width * 0.25, y: size.height * 0.90)
        player1HealthNode.size = CGSize(width: 280, height: 70) // Imposta la dimensione dell'immagine
        player1HealthNode.zPosition = 2
        addChild(player1HealthNode)
        
        player2HealthNode = SKSpriteNode(imageNamed: "life6")
        player2HealthNode.xScale = -1
        player2HealthNode.name = "player2HealthNode"
        player2HealthNode.position = CGPoint(x: size.width * 0.75, y: size.height * 0.90)
        player2HealthNode.size = CGSize(width: 280, height: 70) // Imposta la dimensione dell'immagine
        player2HealthNode.zPosition = 2
        addChild(player2HealthNode)
        
        player1WizardIdle = SKSpriteNode(imageNamed: "idle4")
        player1WizardIdle.name = "player1WizardIdle"
        player1WizardIdle.xScale = -1
        player1WizardIdle.position = CGPoint(x: player1HealthNode.position.x, y: player1HealthNode.position.y - 170)
        player1WizardIdle.zPosition = 2
        player1WizardIdle.size = CGSize(width: 360, height: 350)
        addChild(player1WizardIdle)
        
        
        player2WizardIdle = SKSpriteNode(imageNamed: "idle4")
        player2WizardIdle.name = "player2WizardIdle"
        player2WizardIdle.position = CGPoint(x: player2HealthNode.position.x, y: player2HealthNode.position.y - 170)
        player2WizardIdle.zPosition = 2
        player2WizardIdle.size = CGSize(width: 360, height: 350)
        addChild(player2WizardIdle)
        
        
        let pointsShowed = SKLabelNode(text: "\(player1Points) : \(player2Points)")
        pointsShowed.position =  CGPoint(x: frame.midX, y: frame.maxY - 75)  // Centra il label nella scena
        pointsShowed.zPosition = 2
        pointsShowed.fontSize = 40
        pointsShowed.fontColor = .white
        pointsShowed.fontName = "Arial-BoldMT"
        // Aggiunge il label come figlio alla scena
        addChild(pointsShowed)
    }
    
    func addAgainWizOne(){
        player1WizardIdle = SKSpriteNode(imageNamed: "idle4")
        player1WizardIdle.name = "player1WizardIdle"
        player1WizardIdle.xScale = -1
        player1WizardIdle.position = CGPoint(x: player1HealthNode.position.x, y: player1HealthNode.position.y - 170)
        player1WizardIdle.zPosition = 2
        player1WizardIdle.size = CGSize(width: 360, height: 350)
        addChild(player1WizardIdle)
    }
    
    func addAgainWizTwo(){
        player2WizardIdle = SKSpriteNode(imageNamed: "idle4")
        player2WizardIdle.name = "player2WizardIdle"
        player2WizardIdle.position = CGPoint(x: player2HealthNode.position.x, y: player2HealthNode.position.y - 170)
        player2WizardIdle.zPosition = 2
        player2WizardIdle.size = CGSize(width: 360, height: 350)
        addChild(player2WizardIdle)
    }
    
    
    func applyMagic(whoIsDoing: PlayerStructureData, selectedPlayer: PlayerStructureData, magic: MagicStructureData) -> String {
        var result = ""
        
        // Controlla se il giocatore è bloccato o ha già eseguito una magia di blocco
        if whoIsDoing.isBlocked {
            print("you are locked or have already blocked")
            return result
        }
        
        // Applica i danni
        if magic.damage > 0 {
            selectedPlayer.applyDamage(magic.damage)
            result += "Magic causes \(magic.damage) damage.\n"
        }
        
        // Applica la cura
        if magic.healing > 0 && Int(whoIsDoing.health) + magic.healing <= 150 {
            whoIsDoing.heal(magic.healing)
            result += "Magic heals \(magic.healing) health points.\n"
        }
        
        // Applica il blocco
        if magic.itCanBlock && whoIsDoing.hasBlocked == false {
            applyBlock(whoIsDoingToBlock: whoIsDoing, selectedPlayerToBlock: selectedPlayer)
        }
        
        updateLabels() // Aggiorna le etichette e le immagini della salute
        checkGame() // Verifica lo stato del gioco dopo aver applicato la magia
        spellDone(magicDoing: magic.text, player: whoIsDoing)

        return result
    }

    
    func applyBlock(whoIsDoingToBlock: PlayerStructureData, selectedPlayerToBlock: PlayerStructureData) {
        selectedPlayerToBlock.isBlocked = true
        whoIsDoingToBlock.hasBlocked = true

        let blockedSprite = SKSpriteNode(imageNamed: "freezeMe")
        blockedSprite.name = "blockedSprite"
        blockedSprite.size = CGSize(width: 250, height: 250) // Imposta la dimensione dell'immagine
        blockedSprite.zPosition = 2

        // Creazione della label per il conto alla rovescia
        let countdownLabel = SKLabelNode(text: "5")
        countdownLabel.fontSize = 40
        countdownLabel.fontColor = .red
        countdownLabel.zPosition = 2

        // Posizione della label vicino al giocatore bloccato
        if selectedPlayerToBlock === player1 {
            countdownLabel.position = CGPoint(x: player1HealthNode.position.x, y: player1HealthNode.position.y - 60)
            blockedSprite.position = CGPoint(x: player1HealthNode.position.x, y: player1HealthNode.position.y - 170)
        } else {
            countdownLabel.position = CGPoint(x: player2HealthNode.position.x, y: player2HealthNode.position.y - 60)
            blockedSprite.position = CGPoint(x: player2HealthNode.position.x, y: player2HealthNode.position.y - 170)
        }

        addChild(countdownLabel)
        addChild(blockedSprite)

        // Azione per il conto alla rovescia
        var countdown = 5
        let updateCountdown = SKAction.run {
            countdown -= 1
            countdownLabel.text = "\(countdown)"
        }

        let wait = SKAction.wait(forDuration: 1)
        let countdownSequence = SKAction.sequence([updateCountdown, wait])
        let countdownRepeat = SKAction.repeat(countdownSequence, count: 5)
        let removeLabel = SKAction.removeFromParent()

        // Azione per sbloccare il giocatore
        let unblock = SKAction.run {
            selectedPlayerToBlock.isBlocked = false
            whoIsDoingToBlock.hasBlocked = false
        }

        // Azione per rimuovere lo sprite
        let removeSprite = SKAction.removeFromParent()

        // Combinazione delle azioni per la label
        let sequenceLabel = SKAction.sequence([countdownRepeat, removeLabel])
        countdownLabel.run(sequenceLabel)

        // Combinazione delle azioni per lo sprite
        let sequenceSprite = SKAction.sequence([SKAction.wait(forDuration: 5), unblock, removeSprite])
        blockedSprite.run(sequenceSprite)

        print("unlocked")
    }

    
    
    func spellDone(magicDoing: String, player: PlayerStructureData) {
        let spellNode: SKSpriteNode
        let spellAction: SKAction
        let idleNode: SKSpriteNode
        let idleAction: SKAction
        
        switch magicDoing {
        case "Fire":
            spellNode = fireballSPell
            spellNode.xScale = -0.5
            spellAction = fireballAction

        case "Blizzard":
            spellNode = blizzard
            spellAction = blizzardAction
                
        case "Heal":
            spellNode = heal
            spellAction = healAction
                
        case "Lightning":
            spellNode = thunder
            spellAction = thunderAction
               
        default:
            print("nothing")
            return
        }
        
        // Adjust the position based on the player
        if player === player1 {
            if magicDoing == "Heal"
            {
                spellNode.position = CGPoint(x: player1HealthNode.position.x , y: player1HealthNode.position.y - 190)
            }
            else{
                spellNode.position = CGPoint(x: player2HealthNode.position.x , y: player2HealthNode.position.y - 190)
                
            }
            
            player1WizardIdle.removeFromParent()
            idleNode = SKSpriteNode(imageNamed: "spell1")
            idleNode.xScale = -1
            idleNode.position = CGPoint(x: player1HealthNode.position.x, y: player1HealthNode.position.y - 170)
            idleAction = spellWiz
            
            // Add the idleNode to the scene and run the idle animation
            idleNode.zPosition = 2
            addChild(idleNode)
            
            let idleAnimationSequence = SKAction.sequence([
                idleAction,
                SKAction.run {
                    idleNode.removeFromParent()
                    self.addAgainWizOne()
                    
                },
                SKAction.run {
                    // Add the spell node to the scene
                    spellNode.zPosition = 2
                    
                    // Check if the spellNode already has a parent and remove it if necessary
                    if spellNode.parent != nil {
                        spellNode.removeFromParent()
                    }
                    
                    self.addChild(spellNode)
                    
                    // Create the sequence of actions for the spell
                    let animationSequence = SKAction.sequence([
                        spellAction,
                        SKAction.wait(forDuration: 0.1),
                        SKAction.removeFromParent()
                    ])
                    
                    // Run the spell animation and removal action
                    spellNode.run(animationSequence)
                }
            ])
            
            // Run the idle animation sequence
            idleNode.run(idleAnimationSequence)
        } else {
            if magicDoing == "Heal"{
                spellNode.position = CGPoint(x: player2HealthNode.position.x , y: player2HealthNode.position.y - 170)
            }
            else{
                spellNode.position = CGPoint(x: player1HealthNode.position.x , y: player1HealthNode.position.y - 170)
            }
            player2WizardIdle.removeFromParent()
            idleNode = SKSpriteNode(imageNamed: "spell1")
            idleNode.position = CGPoint(x: player2HealthNode.position.x, y: player2HealthNode.position.y - 170)
            idleAction = spellWiz
            // Add the idleNode to the scene and run the idle animation
            idleNode.zPosition = 2
            addChild(idleNode)
            
            let idleAnimationSequence = SKAction.sequence([
                idleAction,
                SKAction.run {
                    idleNode.removeFromParent()
                    self.addAgainWizTwo()
                    
                },
                SKAction.run {
                    // Add the spell node to the scene
                    spellNode.zPosition = 2
                    
                    // Check if the spellNode already has a parent and remove it if necessary
                    if spellNode.parent != nil {
                        spellNode.removeFromParent()
                    }
                    
                    self.addChild(spellNode)
                    
                    // Create the sequence of actions for the spell
                    let animationSequence = SKAction.sequence([
                        spellAction,
                        SKAction.wait(forDuration: 0.1),
                        SKAction.removeFromParent()
                    ])
                    
                    // Run the spell animation and removal action
                    spellNode.run(animationSequence)
                }
            ])
            
            // Run the idle animation sequence
            idleNode.run(idleAnimationSequence)
        }
    }




    
    func updateLabels() {
        if let pointsShowed = childNode(withName: "pointShowed") as? SKLabelNode {
            pointsShowed.text = "\(player1Points) : \(player2Points)"
            pointsShowed.zPosition = 3
        }
        
        
        
        // Aggiorna le immagini della salute in base ai punti vita
        updateHealthImage(for: player1, node: player1HealthNode)
        updateHealthImage(for: player2, node: player2HealthNode)
    }
    
    func updateHealthImage(for player: PlayerStructureData, node: SKSpriteNode) {
        let health = player.health
        var texture: SKTexture
        
        switch health {
        case 100...150:
            texture = TextureCacheSingle.shared.life6
        case 50..<100:
            texture = TextureCacheSingle.shared.life4
        case 1..<50:
            texture = TextureCacheSingle.shared.life1
        case 0:
            texture = TextureCacheSingle.shared.life0
        default:
            texture = TextureCacheSingle.shared.life0
        }
        
        node.texture = texture
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodes = nodes(at: location)
        
        if !isGameEnded { // Controlla se il gioco non è terminato
            for node in nodes {
                if let nodeName = node.name, nodeName.starts(with: "magicButton") {
                    print("Button \(nodeName) tapped")
                    let index = Int(nodeName.dropFirst("magicButton".count))!
                    let magic = magicBook[index]
                    let result = applyMagic(whoIsDoing: player1, selectedPlayer: player2, magic: magic)
                    print(result)
                    updateLabels()
                    break // Esci dal ciclo dopo aver gestito un pulsante
                }
            }
        }
    }
    
    func startTurnTimer() {
        let wait = SKAction.wait(forDuration: 1)
        let update = SKAction.run {
            self.turnDuration -= 1
            self.timerLabel.text = "Time: \(Int(self.turnDuration))"
            self.timerLabel.fontName = "Helvetica"
            if self.turnDuration <= 0 {
                self.endTurn()
            }
        }
        let sequence = SKAction.sequence([wait, update])
        let repeatAction = SKAction.repeatForever(sequence)
        run(repeatAction, withKey: "turnTimerAction")

        // Avvia il timer AI per eseguire un'azione ogni 5 secondi
        aiTimer = Timer.scheduledTimer(withTimeInterval: aiActionInterval, repeats: true) { _ in
            self.performRandomAIAction()
        }
    }
    
    func startGameTimer() {
        let wait = SKAction.wait(forDuration: 1)
        let update = SKAction.run {
            self.gameTimer -= 1
            if self.gameTimer <= 0 {
                self.endGame()
            }
        }
        let sequence = SKAction.sequence([wait, update])
        let repeatAction = SKAction.repeatForever(sequence)
        run(repeatAction, withKey: "gameTimerAction")
    }
    
    
    func endTurn() {
        removeAction(forKey: "turnTimerAction")
        aiTimer?.invalidate()
        aiTimer = nil
        turnDuration = 30
        startTurnTimer()
    }
    
    func performRandomAIAction() {
        let randomIndex = Int(arc4random_uniform(UInt32(magicBook.count)))
        let magic = magicBook[randomIndex]
        let result = applyMagic(whoIsDoing: player2, selectedPlayer: player1, magic: magic)
        print("AI performed: \(magic.text)")
        print(result)
        updateLabels()
    }
    
    func endGame() {
        var diedWiz: SKSpriteNode!
        var diedAnim: SKAction!
        removeAction(forKey: "gameTimerAction")
        removeAction(forKey: "turnTimerAction")
        aiTimer?.invalidate()
        aiTimer = nil
        
        var winner: String
        if player1.health > player2.health {
            winner = "Player 1"
            player1Points += 1
            diedWiz = SKSpriteNode(imageNamed: "die00_preview_rev_1")
            diedWiz.zPosition = 2
            diedWiz.position = CGPoint(x: player2HealthNode.position.x, y: player2HealthNode.position.y - 170)
            diedWiz.size = CGSize(width: 350, height: 350)
            diedAnim = wizDied
            
            addChild(diedWiz)
           
            let deathAnimationSequence = SKAction.sequence([
                SKAction.run {
                    self.player2WizardIdle.removeFromParent()
                },
                diedAnim
                
            ])
            
    diedWiz.run(deathAnimationSequence)
           
            
        } else if player2.health > player1.health {
            winner = "Player 2"
            player2Points += 1
            diedWiz = SKSpriteNode(imageNamed: "die00_preview_rev_1")
            diedWiz.zPosition = 2
            diedWiz.xScale = -1
            diedWiz.position = CGPoint(x: player1HealthNode.position.x, y: player1HealthNode.position.y - 170)
            diedWiz.size = CGSize(width: 350, height: 350)
            diedAnim = wizDied
            
            addChild(diedWiz)
           
            let deathAnimationSequence = SKAction.sequence([
                SKAction.run {
                    self.player1WizardIdle.removeFromParent()
                },
                diedAnim
                
            ])
            
    diedWiz.run(deathAnimationSequence)
           
            
            
        } else {
            winner = "DRAW"
        }
        
        updateHealthImage(for: player1, node: player1HealthNode)
        updateHealthImage(for: player2, node: player2HealthNode)
        
        let victoryLabel = SKLabelNode(text: "\(winner) Wins!")
        victoryLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 - 150)
        victoryLabel.fontName = "Helvetica"
        victoryLabel.fontSize = 40
        victoryLabel.color = .black
        victoryLabel.zPosition = 5

        let background = SKSpriteNode(imageNamed: "sfondo")
        background.size = CGSize(width: victoryLabel.frame.width + 40, height: victoryLabel.frame.height + 40)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 - 150)
        background.zPosition = 4

        addChild(background)
        addChild(victoryLabel)
        
        let delay = SKAction.wait(forDuration: 5.0)
        let sequence = SKAction.sequence([delay, SKAction.run {
            self.resetScene()
        }])
        
        run(sequence)
        
        updateLabels()
        
        isGameEnded = true
    }

    
    func checkGame() {
        
        if player1.health <= 0 {
            player1.health = 0
            updateLabels()
            endGame()
        } else if player2.health <= 0 {
            player2.health = 0
            updateLabels()
            endGame()
        }
    }
    
    func resetScene() {
        // Rimuovi tutti i nodi dalla scena
        removeAllChildren()
        
        // Reset delle variabili di gioco
        player1 = PlayerStructureData()
        player2 = PlayerStructureData()
        turnDuration = 30
        gameTimer = 30
        isGameEnded = false // Inizia un nuovo round
        
        // Configura la scena nuovamente
        setupScene()
        startTurnTimer()
        startGameTimer()
    }
}

