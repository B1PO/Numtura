import SwiftUI
import AVKit
import Combine

//Clase de sonido
class SoundActive {
    var player: AVAudioPlayer?
    
    func play(withURL url: URL) {
        player = try! AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()
    }
}

struct PlanetView: View {
    @State private var selectedIndex = 0
    @State private var scale: CGFloat = 1.0
    @State var timer: Timer?
    @State var nav: Bool = false
    @State var indexPrime: Int=0
    private let soundPlayer = SoundActive()
    let sound:SoundModel = .init(name: "desplazarSound")
    
  
    let planetImages = ["planet01", "planet02", "planet03"]
    let descriptionPlanet:[String]=[
    "Este planeta esta lleno de aventuras donde la aritmética será la clave",
    "Un planeta donde la geometría ha gobernado cada rincón",
    "Encontrarás un mundo donde deberás utilizar tus conocimientos en fisíca para sobrevivir"
    ]
    let cardBorderColors: [[Color]] = [[.planet3C1, .planet3C2],  [.planet2C1, .planet2C2], [.planet1C1, .planet1C2]]
    let shadowColors:[[Color]]=[[.planet3C2], [.planet2C1], [.planet1C1]]
    let planetsView:[AnyView]=[AnyView(menuArim()),AnyView(PlanetViewGeo()),AnyView(FullPlanetView()) ]
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
                                 description:descriptionPlanet[index],
                                 gradientColors: cardBorderColors[index],
                                 primaryColor:shadowColors[index],
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
                .gesture(
                    DragGesture()  .onChanged {gesture in
                        // Esto se ejecutará mientras se realiza el gesto
                        let gestureTranslation = gesture.translation.width
                        if gestureTranslation > 5 {
                            // Se hizo un gesto hacia la derecha
                            
                            self.soundPlayer.play(withURL: sound.getURL())
                        } else if gestureTranslation < -5 {
                            // Se hizo un gesto hacia la izquierda
                            self.soundPlayer.play(withURL: sound.getURL())
                        }
                    }
                )
                .animation(.easeInOut(duration: 0.5))
                
               
                
                HStack {
                    ForEach(0..<3) { index in
                        ZStack {
                            Circle()
                                .stroke(lineWidth: selectedIndex == index ? 4 : 2)
                                .frame(width: selectedIndex == index ? 44 : 22, height: selectedIndex == index ? 44 : 22)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    self.soundPlayer.play(withURL: sound.getURL())
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
            .transition(.move(edge: .bottom))
          
            
            if nav {
                //*Se manda a llamar al arreglo en base al indexPrime
                planetsView[indexPrime].transition(.move(edge: .bottom))
            }
        }
    }
    
    
    
    func performAction(index: Int) {
        print("Acción para la tarjeta \(index)")
        print("Redirigiendo a otra vista para la tarjeta \(index)")
        self.nav.toggle()
        self.indexPrime=index
        
    }//Fin de funcion
    
}


struct CardView: View {
    var content: String
    var description: String
    var gradientColors: [Color]
    var primaryColor:[Color]
    var planetImage: String
    @Binding var scale: CGFloat
    var index: Int
    var buttonAction: () -> Void
    var fondoColor: LinearGradient {
        return LinearGradient(colors: [.black, primaryColor.first ?? .clear], startPoint: .top, endPoint: .bottom)
    }
    private let soundPlayer = SoundActive()
    let sound:SoundModel = .init(name: "menuSound")
   
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(fondoColor.opacity(0.35))
                .frame(width: 600, height: 600)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 7)
                )
                .padding(.top, 100)
            
            VStack {
                ZStack {
                    Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 7)
                        .frame(width: 350, height: 420)
                        .shadow(color: primaryColor.first ?? .clear, radius: 7, x: 0, y: 0)
                        .offset(y: -230)
                    
                    Image(planetImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: index == 0 ? 510 : (index == 1 ? 795 : 745),
                               height: index == 0 ? 354 : (index == 1 ? 423 : 420))
                        .scaleEffect(scale)
                        .offset(x: index == 0 ? 0 : (index == 1 ? 11 : 11),
                                y: index == 0 ? -231 : (index == 1 ? -233 : -229))
                }
                .padding(.top, 120)
                
                VStack {
                    Text(content)
                        .font(.custom("Montserrat", size: 60))                       .foregroundColor(.white)
                        .shadow(color: .white, radius: 5, x: 0, y: 0)
                        .padding(.top, -240)
                    VStack {
                        Text(description)
                            .font(.custom("Montserrat", size: 26))                       .foregroundColor(.white)
                            .padding(.top, -170).multilineTextAlignment(.center)
                    }.frame(width: 550)
                    
                    Button(action:{
                       soundPlayer.play(withURL: sound.getURL())
                        buttonAction()
                        
                    }) {
                        Text("VIAJAR")
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
