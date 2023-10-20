import SwiftUI
import Combine
//Esto no va en el content
struct ContentView: View {
    
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
                Button("EXPLORAR") {
                }
                .font(.custom("Montserrat", size: 32))                .padding()
                .foregroundColor(Color.white)
                .shadow(color: .white, radius: 10, x: 0.0, y: 0.0)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.2), lineWidth: 5))
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

