//
//  ContentView.swift
//  motionwatch Watch App
//
//  Created by raffaele on 03/07/24.
//

import SwiftUI
import SpriteKit
import Foundation

struct ContentView: View {
    @EnvironmentObject var motionManager: MotionManager

    @State private var backgroundChoosen: String = "null"
    @State private var backgroundFrame: CGRect = CGRect(x: 23, y: 20, width: 150, height: 190)
    @State private var wandFrame: CGSize = CGSize(width: 50, height: 50)
    
    // Funzione per aggiornare il bordo in base alla spell scelta
    func updateBorder(spellChoosen: String) -> String {
        switch spellChoosen {
        case "fireball": return "fireball"
        case "blizzard": return "iceball"
        case "heal": return "healBall"
        case "lightning": return "thunderball"
        default: return "null"
        }
    }

    var body: some View {
        ZStack {
            // Immagine di sfondo che cambia in base alla magia rilevata
            Image(backgroundChoosen)
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea()
                .position(x: backgroundFrame.midX - 5, y: backgroundFrame.midY - 30)
            
            // Immagine del cerchio con la bacchetta magica al centro
            Image("cerchio")
                .resizable()
                .scaledToFill()
                .frame(width: backgroundFrame.width, height: backgroundFrame.height)
                .position(x: backgroundFrame.midX , y: backgroundFrame.midY )
                .edgesIgnoringSafeArea(.all)

            
                
                
                
                // Scorrimento orizzontale per le immagini delle bacchette
                HStack(spacing: 20) { // Spaziatura tra le immagini
                    Image("wand1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 188, height: 160) // Modifica del frame delle bacchette
                        .clipShape(Circle()) // Rende le immagini circolari
                        .onTapGesture {
                            print("tapped")
                        } // Gestore di tocco per la selezione
                }
               
            }
            
        .onChange(of: motionManager.detectedMovement) { newValue in
            if let detectedMovement = newValue {
                let newBackground = updateBorder(spellChoosen: detectedMovement)
                if newBackground != backgroundChoosen {
                    backgroundChoosen = newBackground
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MotionManager())
    }
}
