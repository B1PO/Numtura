import SwiftUI
import AVKit
//Estructura del sonido
struct SoundModel: Hashable {
    let name: String
    func getURL() -> URL {
        return URL(string: Bundle.main.path(forResource: name, ofType: "mp3")!)!
    }
}

//Clase de sonido
class SoundPlayer: ObservableObject {
    var player: AVAudioPlayer?
    
    func play(withURL url: URL) {
        do {
            // Inicializa el reproductor de audio
            player = try AVAudioPlayer(contentsOf: url)
            
            // Configura el reproductor de audio para reproducir en bucle
            player?.numberOfLoops = -1  // -1 indica reproducción en bucle
            player?.volume=0.2
            // Prepara el reproductor para reproducir el sonido
            player?.prepareToPlay()
            
            // Comienza a reproducir el sonido
            player?.play()
        } catch {
            print("Error al inicializar el reproductor de audio: \(error.localizedDescription)")
        }
    }
    func stop(){
        player?.stop()
    }
}


struct BackgroundView: View {
    @State private var scale: CGFloat = 1.0
    @State private var smallStars: [Star] = []
    @State private var mediumStars: [Star] = []
    @State private var largeStars: [Star] = []
    @State var offsets: [UUID: CGSize] = [:]
    @State var timer: Timer?
    @StateObject var soundPlayer = SoundPlayer()
    let sound: SoundModel = .init(name: "bS")
    
    @State private var wave2YOffset: CGFloat = 0
    @State private var wave4YOffset: CGFloat = 0
    
    var body: some View {
        
        ZStack{
            Color.backgroundColor
                .ignoresSafeArea(.all)
            
            VStack {
                Image("wave2")
                    .resizable()
                    .offset(y: wave2YOffset)
                    .padding(.top, -50)
                    .animation(
                        Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                        value: wave2YOffset
                    )
                Image("wave4")
                    .resizable()
                    .offset(y: wave4YOffset)
                    .padding(.bottom, -50)
                    .padding(.leading, 40)

                    .animation(
                        Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                        value: wave4YOffset
                    )
            }
            .frame(width: 1000, height: 1200, alignment: .center)
            
            drawStars(stars: smallStars, offsets: offsets)
            drawStars(stars: mediumStars, offsets: offsets)
            drawStars(stars: largeStars, offsets: offsets)
            
        }.edgesIgnoringSafeArea(.all).onAppear() {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                scale = 1.1
            }
            generateStars()
            soundPlayer.play(withURL: sound.getURL())
            // Actualizar los offsets cada 2 segundos
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                for star in smallStars + mediumStars + largeStars {
                    offsets[star.id] = CGSize(
                        width: CGFloat.random(in: -10...30),
                        height: CGFloat.random(in: -10...30)
                    )
                }
            }
            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                wave2YOffset = 20
                wave4YOffset = -20
            }
        }
        .onDisappear() {
            self.soundPlayer.stop()
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    
    func drawStars(stars: [Star], offsets: [UUID: CGSize]) -> some View {
        ForEach(stars) { star in
            Circle()
                .frame(width: star.initialSize, height: star.initialSize)
                .foregroundColor(.white)
                .opacity(0.4)
                .position(x: star.x, y: star.y)
                .scaleEffect(star.scale)
                .offset(offsets[star.id] ?? CGSize.zero)
                .animation(
                    Animation.easeInOut(duration: star.duration)
                        .repeatForever(autoreverses: true),
                    value: offsets[star.id]
                )
        }
    }
    
    func generateStars() {
        for _ in 0..<20 {
            smallStars.append(Star.makeRandomStar(maxSize: 4))
            mediumStars.append(Star.makeRandomStar(maxSize: 8))
            largeStars.append(Star.makeRandomStar(maxSize: 12))
        }
    }
}

#Preview {
    BackgroundView()
}
