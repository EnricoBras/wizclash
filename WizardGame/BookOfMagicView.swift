import SwiftUI


struct BookOfMagicView: View {
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Schermata")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                Image("Libro")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 500, height: 400)
                    .edgesIgnoringSafeArea(.top)
                    .padding(.top, 0)
                
                spellView(spell: magicBook[0])
                    .position(CGPoint(x: 235, y: 100))
                spellView(spell: magicBook[1])
                    .position(CGPoint(x: 255, y: 300))
                
                ZStack {
                    spellView(spell: magicBook[2])
                        .position(CGPoint(x: 520, y: 100))
                    spellView(spell: magicBook[3])
                        .position(CGPoint(x: 540, y: 300))
                    
                }
                VStack {
                    NavigationLink(destination: GestureView().transition(.blurReplace)) {
                        Image("Watch")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 200)
                            .position(x: 800, y: 200)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {Image("back")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.top, 10)
                        .padding(.trailing, 10)})
                    
                    
                    
                    
                })
            })
            
        }
    }
    
    func spellView(spell: MagicStructureData) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(spell.type.uppercased())
                .fontWeight(.medium)
                .foregroundColor(.pink)
                .padding(.bottom, 5)
            
            HStack(spacing: 1) {
                Image(spell.imageAssociated)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(spell.text)
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text(spell.statusInfo)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            
        }
        .padding()
        .background(Color.white.opacity(0))
        .cornerRadius(10)
        
    }
}
#Preview {
   BookOfMagicView()
}
