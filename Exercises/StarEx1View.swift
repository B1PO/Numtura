import SwiftUI

struct StarEx1View: View {
    @State private var currentContentIndex = 0
    @State private var dialogOpacity = 1.0
    @State private var appliedForce = 10
    @State private var completed = false
    @State private var isUFOAnimating = false
    @State private var asteroidOffset: CGFloat = 0


    let gradientColors: [Color] = [.planet1C1]
    let successColor: Color = .green
    let baseFontSize: CGFloat = 50

    let floatAnimation = Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)

    var body: some View {
        ZStack {
            BackgroundView()
            
            if dialogOpacity == 0 {
                ArithmeticEx1View()
            }

            if dialogOpacity > 0 {
                AE1DialogExpandable(currentContentIndex: $currentContentIndex, dialogOpacity: $dialogOpacity)
            }
        }
        .onAppear {
            withAnimation(self.floatAnimation) {
            }
        }
        .onChange(of: completed) { newValue in
                    if newValue {
                       
                        asteroidOffset = UIScreen.main.bounds.width / 2 + 40
                    }
                }
    }
}

#Preview {
    StarEx1View()
}


