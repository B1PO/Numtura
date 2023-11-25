import SwiftUI

struct TelescopeEx2View: View {
    @State private var currentContentIndex = 0
    @State private var dialogOpacity = 1.0
    @State private var appliedForce = 10
    @State private var completed = false
    @State private var isUFOAnimating = false
    @State private var asteroidOffset: CGFloat = 0


    let gradientColors: [Color] = [.planet1C1]
    let successColor: Color = .green
    let baseFontSize: CGFloat = 50

    var body: some View {
        ZStack {
            BackgroundView()
            
            if dialogOpacity == 0 {
                GameView()

            }

            if dialogOpacity > 0 {
                GE2DialogExpandable(currentContentIndex: $currentContentIndex, dialogOpacity: $dialogOpacity)
            }
        }
    }
}

#Preview {
    TelescopeEx2View()
}



