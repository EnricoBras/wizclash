import SwiftUI

var selected: String = "Deepforest"

struct ChooseBackgroundView: View {
    enum Arenas: String, CaseIterable, Identifiable {
        case Deepforest, Forest, Skygarden, Magicforest
        var id: Self { self }
        
        var imageName: String {
            return self.rawValue
        }
    }

    @State private var selectedArena: Arenas = .Deepforest
    @State private var currentArena: Arenas = .Deepforest
    
    var body: some View {
        VStack {
            Text("Choose your Arena: \(selectedArena.rawValue)")
                .font(.headline)
                .padding(.top)
            
            TabView(selection: $currentArena) {
                ForEach(Arenas.allCases) { arena in
                    ZStack {
                        GeometryReader { geometry in
                            Image(arena.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                        }
                        .tag(arena)
                        
                        VStack {
                            Text(arena.imageName)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 3, x: 0, y: 0)
                                .padding(.top, 30)
                            Spacer()
                            Button(action: {
                                selectedArena = currentArena
                                selected = selectedArena.rawValue
                                print(selectedArena.rawValue)
                            }) {
                                Text("Select")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .padding(.bottom, 20)
                            }
                        }
                        .padding()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ChooseBackgroundView()
        .environmentObject(MotionManager())
}
