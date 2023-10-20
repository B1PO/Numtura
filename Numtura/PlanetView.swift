import SwiftUI

struct PlanetView: View {
    @State private var selectedIndex = 0
    @State private var scale: CGFloat = 1.0
    @State var timer: Timer?
    @State var nav: Bool = false
    
    
    let planetImages = ["planet01", "planet02", "planet03"]
    let cardBorderColors: [[Color]] = [[.planet3C1, .planet3C2],  [.planet2C1, .planet2C2], [.planet1C1, .planet1C2]]
    
    var body: some View {
        ZStack {
            
            BackgroundView()
            
            Image("Moon2")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .offset(x: CGFloat(selectedIndex - 1) * 40, y: nav ? -700 :-500)
                .animation(.easeInOut(duration: 0.5))
            
            
            VStack {
                
                TabView(selection: $selectedIndex) {
                    ForEach(0..<3) { index in
                        CardView(content: ["ARIM", "GEOS", "NEWT"][index],
                                 description: ["Planeta de aritmetica.",
                                               "Planeta de geometría.",
                                               "Planeta de física."][index],
                                 gradientColors: cardBorderColors[index],
                                 planetImage: planetImages[index],
                                 scale: $scale,
                                 index: index,
                                 buttonAction: {
                            performAction(index: index)
                        })
                        .rotationEffect(.degrees(selectedIndex == index ? 0 : -10))
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.5))
                
                HStack {
                    ForEach(0..<3) { index in
                        ZStack {
                            Circle()
                                .stroke(lineWidth: selectedIndex == index ? 4 : 2)
                                .frame(width: selectedIndex == index ? 44 : 22, height: selectedIndex == index ? 44 : 22)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    selectedIndex = index
                                }
                            
                            if selectedIndex == index {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        LinearGradient(gradient: Gradient(colors: cardBorderColors[index]), startPoint: .leading, endPoint: .trailing)
                                            .mask(Circle())
                                    )
                            }
                        }
                        .padding(.bottom, 100)
                        .animation(.easeInOut(duration: 0.3))
                    }
                    .padding(40)
                }
            }
            .offset(x: nav ? UIScreen.main.bounds.width*0 : UIScreen.main.bounds.width*0  , y: nav ? UIScreen.main.bounds.height * -1 : UIScreen.main.bounds.height * 0)
            .animation(.spring())
            
            if nav {
                RocketLoadingView()
                    .padding(.top, -70)
                    .transition(.move(edge: .bottom))
                    .animation(.easeOut(duration: 2))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                            self.nav.toggle()
                        }
                    }
                
            }
        }
    }
    
    
    
    func performAction(index: Int) {
        // Aquí, puedes añadir las acciones de cada tarjeta
        print("Acción para la tarjeta \(index)")
        switch index {
           case 0:
               print("Redirigiendo a otra vista para la tarjeta 0")
               // Aquí puedes añadir el código para redirigir a otra vista
               
            self.nav.toggle()
            
           case 1:
               print("Acción de impresión para la tarjeta 1")
            self.nav.toggle()

           case 2:
               print("Acción para la tarjeta 2")
            self.nav.toggle()

           default:
               break
           }
    }
}


struct CardView: View {
   var content: String
   var description: String
   var gradientColors: [Color]
   var planetImage: String
   @Binding var scale: CGFloat
   var index: Int
   var buttonAction: () -> Void
       
   var body: some View {
       ZStack {
           RoundedRectangle(cornerRadius: 25)
               .fill(Color.planetFrameColor.opacity(0.3))
               .frame(width: 600, height: 600)
               .overlay(
                   RoundedRectangle(cornerRadius: 25)
                       .stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 7)
               )
               .padding(.top, 100)
           
           VStack {
               ZStack {
                   Circle()
                       .stroke(Color.white, lineWidth: 8)
                       .frame(width: 350, height: 420)
                       .shadow(color: .white, radius: 8, x: 0, y: 0)
                       .offset(y: -230)
                   
                   Image(planetImage)
                       .resizable()
                       .scaledToFit()
                       .frame(width: index == 0 ? 720 : (index == 1 ? 795 : 740),
                              height: index == 0 ? 410 : (index == 1 ? 417 : 414))
                       .scaleEffect(scale)
                       .offset(x: index == 0 ? 23 : (index == 1 ? 11 : 13),
                               y: index == 0 ? -231 : (index == 1 ? -233 : -229))
               }
               .padding(.top, 120)
               
               VStack {
                   Text(content)
                       .font(.custom("Montserrat", size: 60))                       .foregroundColor(.white)
                       .shadow(color: .white, radius: 5, x: 0, y: 0)
                       .padding(.top, -240)
                   
                   Text(description)
                       .font(.custom("Montserrat", size: 20))                       .foregroundColor(.white)
                       .padding(.top, -200)
                   
                   Button(action: buttonAction) {
                       Text("IR")
                           .font(.custom("Montserrat", size: 20))
                           .foregroundColor(.black)
                           .padding(.trailing, 40)
                           .padding(.leading, 40)
                           .padding()
                           .background(Color.white)
                           .cornerRadius(40)
                   }
                   
               }
           }
           
       }
       .padding(.top, 140)
   }
}

struct PlanetView_Previews: PreviewProvider {
   static var previews: some View {
       PlanetView()
   }
}

