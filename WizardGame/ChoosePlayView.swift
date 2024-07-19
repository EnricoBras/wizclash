import SwiftUI

struct ChoosePlayView: View {
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
                        
                        Image("TITOLOO")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 400, height: 200)
                            .position(x: 369, y: 80)
                        
                        Spacer()

                        NavigationLink(destination: GameView().transition(.blurReplace)) {
                            Image("Single")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 80)
                                .position(x: 220, y: 115)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: ConnectingView().transition(.blurReplace)) {
                            Image("Multi")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 80)
                                .position(x: 520, y: 15)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: TrainingView().transition(.blurReplace)) {
                            Image("TRAINING")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 280, height: 70)
                                .position(x: 370, y: 13)
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


#Preview{
    ChoosePlayView()
        .environmentObject(MotionManager())
}

