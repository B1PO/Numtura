import SwiftUI
import Combine
import AVKit
struct ContentView: View {
    @State var showPlanetView: Bool = false
    @State var nav: Bool = false
    private let soundPlayer = SoundActive()
    let sound:SoundModel = .init(name: "nA")
    
    var body: some View {
        ZStack {
            BackgroundView().edgesIgnoringSafeArea(.all)
            VStack{
                LogoView().opacity(nav ? 0 : 1)
                    .scaleEffect(nav ? 0.8 : 1)
                    .animation(.easeInOut(duration: 0.5))
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 400, height: 3)
                    .foregroundColor(.clear)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.white)
                            .frame(width: 400, height: 3)
                    ).padding(.bottom, 100)
                Button(action: {
                    nav.toggle()
                    self.soundPlayer.play(withURL: sound.getURL())
                }) {
                    NeonText(text: "INICIAR", size: 43)
                }
                .buttonStyle(NeonButtonStyle())
                
                
            }.offset(x: nav ? UIScreen.main.bounds.width*0 : UIScreen.main.bounds.width*0  , y: nav ? UIScreen.main.bounds.height * -1 : UIScreen.main.bounds.height * 0)
                .animation(.spring())
                .transition(.move(edge: .bottom))
            //Fin de ZStack
            if nav {
                PlanetView().transition(.move(edge: .bottom))
            }
            //Fin de Vstack
        }//Fin ZStack 1
    }//Fin body
}//Fin de ContentView

struct LogoView: View {
    var body: some View {
        ZStack {
            VStack{
                Image("cohetenum").resizable().frame(width: 550, height: 300).padding(.bottom,10)
                NeonText(text: "NUMTURA", size: 90)
                    .padding(.bottom,30)
                
            }
        }//Fin ZStack 1
    }//Fin body
}//Fin de ContentView

//Estructura para trxto neon
struct NeonText: View {
    var text: String
    var size: CGFloat
    
    var body: some View {
        ZStack {
            Text(text)
                .font(.custom("Montserrat", size: size))
                .foregroundColor(.white)
                .bold()
                .overlay(
                    Text(text)
                        .font(.custom("Montserrat", size: size))
                        .foregroundColor(.white)
                        .bold()
                        .blur(radius: 9) // Ajusta el radio para cambiar la intensidad del resplandor
                        .opacity(0.9) // intensidad del resplandor
                )
        }
    }
}

//Estructura del boton
struct NeonButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal,70)
            .padding(.vertical,30)
            .background(
                RoundedRectangle(cornerRadius: 45)
                    .stroke(Color.white, lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 45)
                            .foregroundColor(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 45)
                                    .stroke(Color.white, lineWidth: 2)
                                    .blur(radius: 7)
                                    .opacity(0.9)
                            )
                    )
            )
    }
}


//Estructura de las estrellas
struct Star: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var initialSize: CGFloat
    var scale: CGFloat
    var duration: Double
    
    static func makeRandomStar(maxSize: CGFloat) -> Star {
        let x = CGFloat.random(in: 0..<1024)
        let y = CGFloat.random(in: 0..<1366)
        let initialSize = CGFloat.random(in: 3...maxSize)
        let scale = CGFloat.random(in: 1.01...1.05)
        let duration = Double.random(in: 3...6)
        return Star(x: x, y: y, initialSize: initialSize, scale: scale, duration: duration)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

