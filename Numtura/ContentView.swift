import SwiftUI
import Combine
//Esto no va en el content
struct ContentView: View {
    @State var showPlanetView: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Image("cohetenum")
                    .resizable()
                    .frame(width: 490, height: 270, alignment: .center)
                // Texto con efecto de glow
                Text("N U M T U R A")
                    .font(.custom("Montserrat", size: 60))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .shadow(color: .white, radius: 10, x: 0.0, y: 0.0)
                
                // Línea debajo del texto
                Rectangle()
                    .frame(height: 5)
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 10, x: 0.0, y: 0.0)
                    .padding([.leading, .trailing], 290)
                Text("Hora de iniciar tu aventura")
                    .font(.custom("Montserrat", size: 32))
                    .foregroundColor(Color.white)
                    
    
                // Botón "Explorar" con efecto de glow
                ZStack{
                    Rectangle()
                        .frame(width: 400, height: 70)
                        .cornerRadius(20)
                        .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.40, alpha: 1.00)))
                        .opacity(0.2)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(UIColor(red: 0.60, green: 0.60, blue: 0.62, alpha: 1.00)), lineWidth: 5)
                                .opacity(0.2)
                        }
                    
                    Text("EXPLORAR")
                        .font(.custom("Montserrat", size: 30))
                        .padding()
                        .foregroundColor(Color.white)
                        .shadow(color: .white, radius: 10, x: 0.0, y: 0.0)
                }.onTapGesture {
                    //Codigo a ejecutar simulando un Button
                    showPlanetView.toggle()
                }
                
                .fullScreenCover(isPresented: $showPlanetView, content: {
                    PlanetView()
                })
            }
        }
    }
    
}

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

