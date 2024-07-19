/*import SwiftUI
import SpriteKit

struct ContentView: View {
    @EnvironmentObject var motionManager: MotionManager
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Image("Schermata2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    VStack {
                        Spacer()

                        VStack {
                            // Logo Placeholder
                            Image("logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 350, height: 100)
                                .position(x: 369, y: 90)
                            
                            Spacer()
                            
                            // Buttons with a semi-transparent background
                            NavigationLink(destination: GameView().transition(.blurReplace)) {
                                Image("play")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 110)
                                    .position(x: 369, y: 90)
                            }
                            .buttonStyle(PlainButtonStyle())

                            NavigationLink(destination: BookOfMagicView().transition(.blurReplace)) {
                                Image("magicBook")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .position(x: 377, y: 70)
                            }
                            .buttonStyle(PlainButtonStyle())

                            NavigationLink(destination: ConnectingView().transition(.blurReplace)) {
                                Image("Connect")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .position(x: 366, y: 50)
                            }
                            .buttonStyle(PlainButtonStyle())
                                NavigationLink(destination: ChooseBackgroundView()) {
                                    Text("BACKGROUND")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue.opacity(0.7))
                                        .cornerRadius(10)
                                }
                            NavigationLink(destination: TrainingView()) {
                                Text("Training")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue.opacity(0.7))
                                    .cornerRadius(10)
                            }
                            }
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)  // Ensures the VStack takes up the full width
                        
                        Spacer()

                        // Settings Icon
                        HStack {
                            Spacer()
                            /*Button(action: {
                                // Action for settings
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue.opacity(0.7))
                                    .clipShape(Circle())
                            }*/
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }


#Preview{
    ContentView()
}*/

import SwiftUI
import SpriteKit
import AVFoundation

struct ContentView: View {
   var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Image("Schermata")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    VStack {
                        Spacer()

                        VStack {
                            // Logo Placeholder
                            Image("TITOLOO")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 400, height: 200)
                                .position(x: 375, y: 80)
                            
                            Spacer()
                            
                            // Buttons with a semi-transparent background
                            NavigationLink(destination: ChoosePlayView().transition(.blurReplace)) {
                                Image("Play")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 80)
                                    .position(x: 380, y: 100)
                            }
                            .buttonStyle(PlainButtonStyle())

                            
                            .buttonStyle(PlainButtonStyle())

                            NavigationLink(destination: BookOfMagicView().transition(.blurReplace)) {
                                Image("Book")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 80)
                                    .position(x: 373, y: 50)
                            }
                            .buttonStyle(PlainButtonStyle())
                                
                            }
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)  // Ensures the VStack takes up the full width
                        
                        Spacer()

                        // Settings Icon
                        HStack {
                            Spacer()
                            
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
    }


#Preview{
    ContentView()
        .environmentObject(MotionManager())
}
