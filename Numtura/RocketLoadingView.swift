import SwiftUI

struct RocketLoadingView: View {
    var body: some View {
            
            VStack{
                Image("cohete")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .rotationEffect(.degrees(-45))
            }.position(x: UIScreen.main.bounds.width * 0.63)
            
    }
}

#Preview {
    RocketLoadingView()
}

