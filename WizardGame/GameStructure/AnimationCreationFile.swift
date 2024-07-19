//
//  AnimationCreationFile.swift
//  CodeNameWizard
//
//  Created by Enrico Brasiello on 30/06/24.
//

//da inserire le animazioni create separatamente
import Foundation
import SpriteKit

//Animazione fireball
        let fireballSPell = SKSpriteNode(imageNamed: "fire1")
        let f1 = SKTexture(imageNamed: "fire1")
        let f2 = SKTexture(imageNamed: "fire2")
        let f3 = SKTexture(imageNamed: "fire3")
        let f4 = SKTexture(imageNamed: "fire4")
        let f5 = SKTexture(imageNamed: "fire5")
        let f6 = SKTexture(imageNamed: "fire6")
        let f7 = SKTexture(imageNamed: "fire7")
        let f8 = SKTexture(imageNamed: "fire8")
let f9 = SKTexture(imageNamed: "fire9")
let f10 = SKTexture(imageNamed: "fire10")
let f11 = SKTexture(imageNamed: "fire11")
let f12 = SKTexture(imageNamed: "fire12")
let f13 = SKTexture(imageNamed: "fire13")
let f14 = SKTexture(imageNamed: "fire14")

       
        
        let fireballAction = SKAction.animate(with: [f1, f2, f3 , f4 , f5, f6, f7 , f8 , f9, f10, f11, f12, f13, f14 ], timePerFrame: 0.1)
        
        




//Animazione Blizzard
let blizzard = SKSpriteNode(imageNamed: "charge_effect_10_preview_rev_1")
let b1 = SKTexture(imageNamed: "charge_effect_01_preview_rev_1")
let b2 = SKTexture(imageNamed: "charge_effect_02_preview_rev_1")
let b3 = SKTexture(imageNamed: "charge_effect_03_preview_rev_1")
let b5 = SKTexture(imageNamed: "charge_effect_04_preview_rev_1")
let b6 = SKTexture(imageNamed: "charge_effect_05_preview_rev_1")
let b7 = SKTexture(imageNamed: "charge_effect_06_preview_rev_1")
let b8 = SKTexture(imageNamed: "charge_effect_07_preview_rev_1")
let b9 = SKTexture(imageNamed: "charge_effect_08_preview_rev_1")
let b10 = SKTexture(imageNamed: "charge_effect_09_preview_rev_1")
let b11 = SKTexture(imageNamed: "charge_effect_10_preview_rev_1")

let blizzardAction = SKAction.animate(with: [b11 , b10 , b9 , b8, b7 , b6 , b5 , b3 , b2 , b1], timePerFrame: 0.1)




//Animazione della cura
let heal = SKSpriteNode(imageNamed: "healframe1")
let h1 = SKTexture(imageNamed: "healframe1")
let h2 = SKTexture(imageNamed: "healframe2")
let h3 = SKTexture(imageNamed: "healframe3")
let h4 = SKTexture(imageNamed: "healframe4")
let h5 = SKTexture(imageNamed: "healframe5")
let h6 = SKTexture(imageNamed: "healframe6")
let h7 = SKTexture(imageNamed: "healframe7")
let h8 = SKTexture(imageNamed: "healframe8")
let h9 = SKTexture(imageNamed: "healframe9")



let healAction = SKAction.animate(with: [h1, h2, h3 , h4 , h5, h6, h7, h8, h9], timePerFrame: 0.1)






let thunder = SKSpriteNode(imageNamed: "thunder1")
let t1 = SKTexture(imageNamed: "thunder1")
let t2 = SKTexture(imageNamed: "thunder2")
let t3 = SKTexture(imageNamed: "thunder3")
let t4 = SKTexture(imageNamed: "thunder4")
let t5 = SKTexture(imageNamed: "thunder5")
let t6 = SKTexture(imageNamed: "thunder6")




let thunderAction = SKAction.animate(with: [t1, t2, t3 , t4 , t5, t6], timePerFrame: 0.1)




let wizardIdle = SKSpriteNode(imageNamed: "idle4")


let s1 = SKTexture(imageNamed: "idle4")
let s2 = SKTexture(imageNamed: "idle5")
let s3 = SKTexture(imageNamed: "idle6")

let s5 = SKTexture(imageNamed: "idle7")
let s6 = SKTexture(imageNamed: "idle8")
let s7 = SKTexture(imageNamed: "idle9")
let s8 = SKTexture(imageNamed: "idle10")
let s9 = SKTexture(imageNamed: "idle11")
let s10 = SKTexture(imageNamed: "idle12")
let s11 = SKTexture(imageNamed: "idle13")

let wizaction = SKAction.animate(with: [s1, s2, s3 , s5, s6, s7 , s8 , s9 , s10 , s11], timePerFrame: 0.1)



let spellWizard = SKSpriteNode(imageNamed: "spell1")
let sp1 = SKTexture(imageNamed: "spell1")
let sp2 = SKTexture(imageNamed: "spell2")
let sp3 = SKTexture(imageNamed: "spell3")
let sp4 = SKTexture(imageNamed: "spell4")
let sp5 = SKTexture(imageNamed: "spell5")
let sp6 = SKTexture(imageNamed: "spell6")
let sp7 = SKTexture(imageNamed: "spell7")

let spellWiz = SKAction.animate(with: [sp1, sp2, sp3, sp4, sp5, sp6, sp7], timePerFrame: 0.1)




let diedWizard = SKSpriteNode(imageNamed: "die00_preview_rev_1")

// Set the position of the wizard

let di1 = SKTexture(imageNamed: "die00_preview_rev_1")
let di2 = SKTexture(imageNamed: "die01_preview_rev_1")
let di3 = SKTexture(imageNamed: "die02_preview_rev_1")

let di5 = SKTexture(imageNamed: "die05_preview_rev_1")
let di6 = SKTexture(imageNamed: "die06_preview_rev_1")
let di7 = SKTexture(imageNamed: "die07_preview_rev_1")

let wizDied = SKAction.animate(with: [di1, di2, di3 , di5, di6, di7], timePerFrame: 0.1)


/* let wizard = SKSpriteNode(imageNamed: "charge_effect_10_preview_rev_1")
 
 // Set the position of the wizard
 wizard.position = CGPoint(x: 100, y: 100)
 
 // Add the wizard node to the scene
 self.addChild(wizard)
 
 let s1 = SKTexture(imageNamed: "charge_effect_01_preview_rev_1")
 let s2 = SKTexture(imageNamed: "charge_effect_02_preview_rev_1")
 let s3 = SKTexture(imageNamed: "charge_effect_03_preview_rev_1")
 let s5 = SKTexture(imageNamed: "charge_effect_04_preview_rev_1")
 let s6 = SKTexture(imageNamed: "charge_effect_05_preview_rev_1")
 let s7 = SKTexture(imageNamed: "charge_effect_06_preview_rev_1")
 let s8 = SKTexture(imageNamed: "charge_effect_07_preview_rev_1")
 let s9 = SKTexture(imageNamed: "charge_effect_08_preview_rev_1")
 let s10 = SKTexture(imageNamed: "charge_effect_09_preview_rev_1")
 let s11 = SKTexture(imageNamed: "charge_effect_10_preview_rev_1")
 
 let wizaction = SKAction.animate(with: [s11 , s10 , s9 , s8, s7 , s6 , s5 , s3 , s2 , s1], timePerFrame: 0.1)
 
 wizard.run(SKAction.repeatForever(wizaction))*/







/*let wizard = SKSpriteNode(imageNamed: "ezgif-frame-001_preview_rev_1")
 
 // Set the position of the wizard
 wizard.position = CGPoint(x: 100, y: 100)
 
 // Add the wizard node to the scene
 self.addChild(wizard)
 
 let h1 = SKTexture(imageNamed: "ezgif-frame-001_preview_rev_1")
 let h2 = SKTexture(imageNamed: "ezgif-frame-003_preview_rev_1")
 let h3 = SKTexture(imageNamed: "ezgif-frame-005_preview_rev_1")
 let h4 = SKTexture(imageNamed: "ezgif-frame-009_preview_rev_1")
 let h5 = SKTexture(imageNamed: "ezgif-frame-012_preview_rev_1")
 let h6 = SKTexture(imageNamed: "ezgif-frame-015_preview_rev_1")
 let h7 = SKTexture(imageNamed: "ezgif-frame-018_preview_rev_1")
 let h8 = SKTexture(imageNamed: "ezgif-frame-021_preview_rev_1")
 let h9 = SKTexture(imageNamed: "ezgif-frame-024_preview_rev_1")

 
 
 let wizaction = SKAction.animate(with: [s1, s2, s3 , s4 , s5, s6, s7, s8, s9], timePerFrame: 0.1)
 
 wizard.run(SKAction.repeatForever(wizaction))*/






/*wizard.position = CGPoint(x: -150, y: 10)
 
 // Add the wizard node to the scene
 self.addChild(wizard)
 
 let s1 = SKTexture(imageNamed: "Fireball_Effect_01")
 let s2 = SKTexture(imageNamed: "Fireball_Effect_02")
 let s3 = SKTexture(imageNamed: "Fireball_Effect_03")
 let s4 = SKTexture(imageNamed: "Fireball_Effect_04")
 let s5 = SKTexture(imageNamed: "Fireball_Effect_05")
 let s6 = SKTexture(imageNamed: "Fireball_Effect_06")
 let s7 = SKTexture(imageNamed: "Fireball_Effect_07")
 let s8 = SKTexture(imageNamed: "Fireball_Effect_08")
 let s9 = SKTexture(imageNamed: "Fireball_Effect_09")
 let s10 = SKTexture(imageNamed: "Fireball_Effect_10")
 let s11 = SKTexture(imageNamed: "Fireball_Effect_11")
 let s12 = SKTexture(imageNamed: "Fireball_Effect_12")
 let s13 = SKTexture(imageNamed: "Fireball_Effect_13")
 let s14 = SKTexture(imageNamed: "Fireball_Effect_14")
 let s15 = SKTexture(imageNamed: "Fireball_Effect_15")
 let s16 = SKTexture(imageNamed: "Fireball_Effect_16")
 let s17 = SKTexture(imageNamed: "Fireball_Effect_17")
 let s18 = SKTexture(imageNamed: "Fireball_Effect_18")
 let s19 = SKTexture(imageNamed: "Fireball_Effect_19")
 let s20 = SKTexture(imageNamed: "Fireball_Effect_20")
 let s21 = SKTexture(imageNamed: "Fireball_Effect_21")
 let s22 = SKTexture(imageNamed: "Fireball_Effect_22")
 let s23 = SKTexture(imageNamed: "Fireball_Effect_23")
 let s24 = SKTexture(imageNamed: "Fireball_Effect_24")
 let s25 = SKTexture(imageNamed: "Fireball_Effect_25")
 
 
 let wizaction = SKAction.animate(with: [s1, s2, s3 , s4 , s5, s6, s7 , s8 , s9 , s10 , s11 , s12 , s13 , s14 , s15 , s16 , s17 , s18 , s19 , s20 , s21 , s22 , s23 , s24 , s25 ], timePerFrame: 0.1)
 let move = SKAction.moveBy(x: 150, y: 10, duration: 2)
 wizard.run(SKAction.repeatForever(wizaction))
 
 let sound = SKAction.playSoundFileNamed("cartoon_fireball_sound_effect_V77xa-SDI-I_140",waitForCompletion: true)
 
 let hideAction = SKAction.run{self.wizard.isHidden = true
 }
 
 let sequence = SKAction.sequence([sound,move,hideAction])
 
 wizard.run(sequence)
 */
