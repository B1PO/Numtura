import SwiftUI

struct PhysicsEx2View: View {
    var body: some View {
        ZStack{
            BackgroundView()
            VStack{
                PE1Dialog()
                
                ZStack {
                    Image("ufo")
                        .resizable()
                        .frame(width: 500, height: 500)
                    Image("asteroid")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .padding(.leading, 550)
                    Image("asteroid")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .padding(.trailing, 550)
                }
                
                
                
            }
        }
    }
}

#Preview {
    PhysicsEx2View()
}
