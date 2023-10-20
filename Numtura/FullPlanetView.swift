import SwiftUI

struct FullPlanetView: View {

    @State private var rotation: Double = 0

    var body: some View {

        ZStack {
                ContentView()
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 38)
                    .frame(width: 800, height: 800)
                    .shadow(color: .white, radius: 8, x: 0, y: 0)

                
                Image("fullplanet03")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(-90))
                    .frame(width: 1400, height: 1400)
                    .animation(.interactiveSpring(duration: 0.1))
                
                Image("space-shuttlep")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding(.bottom, 910)
                
                
                
            }
            .rotationEffect(Angle.degrees(rotation))
            .padding(.bottom, -1300)
            .gesture(
                DragGesture(minimumDistance: 3, coordinateSpace: .local)
                    .onEnded { value in
                        withAnimation {
                            rotation += value.translation.width > 0 ? 120 : -120
                        }
                    }
        )
            Test()
                .padding(.top, 1000)
        }
    }
}

struct FullPlanetView_Previews: PreviewProvider {
    static var previews: some View {
        FullPlanetView()
    }
}

