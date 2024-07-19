import SwiftUI

struct GestureView: View {
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
                    .position(x: 370, y: 200)
                
                Image("WatchFire")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 150)
                    .position(x: 230, y: 120)
                Image("Freccia3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 50)
                    .position(x: 230, y: 50)
                
                Image("WatchHeal")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 150)
                    .position(x: 230, y: 280)
                Image("Freccia3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 50)
                    .position(x: 230, y: 210)
                Image("Freccia4")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 50)
                    .position(x: 230, y: 350)
                
                Image("WatchBlizzard")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 150)
                    .position(x: 510, y: 80)
                Image("Freccia4")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 50)
                    .position(x: 509, y: 155)
                
                Image("WatchLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 150)
                    .position(x: 510, y: 300)
                Image("Freccia")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .position(x: 449, y: 300)
                Image("Freccia2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .position(x: 569, y: 300)
                
                
            }
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
}

#Preview {
    GestureView()
       
}
