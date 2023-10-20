
import SwiftUI

struct GeometryEx1: View {
    var body: some View {
        ZStack{
            BackgroundView()
            VStack{
                Text("Elimina las figuras semejantes")
                    .font(.custom("Montserrat", size: 40))                       .foregroundColor(.white)
                    .shadow(color: .white, radius: 5, x: 0, y: 0)
//                    .padding(.top, -240)
                
                HStack{
                    Image("figura1")
                        .resizable()
                        .frame(width: 400, height: 220)
                        .padding(.leading,-25)
                        .rotationEffect(.degrees(10))
                    
                    Rectangle()
                        .frame(width: 120, height: 120)
                        .foregroundColor(Color(UIColor(red: 0.65, green: 0.85, blue: 0.56, alpha: 1.00)))
                        .padding(.leading,-15)
                        .padding(.top, 70)
                        .rotationEffect(.degrees(45))
                    
                    Image("figura2")
                        .resizable()
                        .frame(width: 380, height: 250)
                        .rotationEffect(.degrees(-28))
                        .padding(.bottom,35)
                        .padding(.leading,-45)
                        
                }
                
                HStack{
                    Image("figura4")
                        .resizable()
                        .frame(width: 440, height: 260)
                        .padding(.trailing,20)
                    
                    Image("figura3")
                        .resizable()
                        .frame(width: 250, height: 150)
                        .padding(.leading,-90)
                    
    
                    VStack{
                        Image("figura1")
                            .resizable()
                            .frame(width: 255, height: 120)
                            .padding(.leading,-25)
                            .rotationEffect(.degrees(10))
                        
                        Image("figura5")
                            .resizable()
                            .frame(width: 400, height: 220)
                            .padding(.leading,-70)
                    }
                    
                }
                
                HStack{
                    Image("figura2")
                        .resizable()
                        .frame(width: 230, height: 120)
                        .rotationEffect(.degrees(30))
                    
                    Rectangle()
                        .frame(width: 180, height: 180)
                        .foregroundColor(Color(UIColor(red: 0.65, green: 0.85, blue: 0.56, alpha: 1.00)))
                    
                    Image("figura3")
                        .resizable()
                        .frame(width: 180, height: 100)
                        .rotationEffect(.degrees(25))
                        .padding(.top,30)
                }
                
                Image("basurero")
                    .resizable()
                    .frame(width: 180, height: 100)
                
            }
        }
    }
}

#Preview {
    GeometryEx1()
}

