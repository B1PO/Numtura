import SwiftUI

struct Background: View {
    @State private var scale: CGFloat = 1.0
    @State private var smallStars: [Star] = []
    @State private var mediumStars: [Star] = []
    @State private var largeStars: [Star] = []
    @State var offsets: [UUID: CGSize] = [:]
    @State var timer: Timer?
    
    var body: some View {
        ZStack{
            Color.backgroundColor
                .ignoresSafeArea(.all)
            
            VStack {
                Image("wave2")
                    .resizable()
                Image("wave4")
                    .resizable()
            }
            .frame(width: 1000, height: 1200, alignment: .center)
            
            drawStars(stars: smallStars, offsets: offsets)
            drawStars(stars: mediumStars, offsets: offsets)
            drawStars(stars: largeStars, offsets: offsets)
            
        }.onAppear() {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                scale = 1.1
            }
            generateStars()
            
            // Actualizar los offsets cada 2 segundos
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                for star in smallStars + mediumStars + largeStars {
                    offsets[star.id] = CGSize(
                        width: CGFloat.random(in: -10...20),
                        height: CGFloat.random(in: -10...20)
                    )
                }
            }
        }
        .onDisappear() {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    
    func drawStars(stars: [Star], offsets: [UUID: CGSize]) -> some View {
        ForEach(stars) { star in
            Circle()
                .frame(width: star.initialSize, height: star.initialSize)
                .foregroundColor(.white)
                .opacity(0.8)
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
    Background()
}

