import SwiftUI

struct PhysicsEx2View: View {
    @State private var currentContentIndex = 0
    @State private var dialogOpacity = 1.0
    @State private var appliedForce = 10
    @State private var completed = false
    @State private var isUFOAnimating = false
    @State private var asteroidOffset: CGFloat = 0
    @State var nav: Bool = false
    
    private let soundPlayer = SoundActive()
    let soundWin:SoundModel = .init(name: "soundWin")
    let soundMenu:SoundModel = .init(name: "menuSound")


    let gradientColors: [Color] = [.planet1C1]
    let successColor: Color = .green
    let baseFontSize: CGFloat = 50

    let floatAnimation = Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)
    
    let vibrationAnimation = Animation.linear(duration: 0.1).repeatCount(3)

    var body: some View {
        ZStack {
            BackgroundView()
            
            if dialogOpacity == 0 {
                
                ZStack {
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 50){
                        if !completed {
                                            PE1DialogIG()
                        } else {
                            SuccessDialog(nav: $nav)
                            
                            
                            
                        }
                         
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.planetFrameColor.opacity(0.3))
                                    .frame(width: 350, height: 150)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 7)
                                    )
                                
                                Text("FUERZA REQUERIDA")
                                    .font(.custom("digitalism", size: 40))
                                    .foregroundColor(.planet1C1)
                                    .padding(.bottom, 50)
                                    .shadow(color: .planet1C1, radius: 10, x: 0.0, y: 0.0)
                                Text("110 newtons")
                                    .font(.custom("digitalism", size: 60))
                                    .foregroundColor(.planet1C1)
                                    .padding(.top, 60)
                                    .shadow(color: .planet1C1, radius: 10, x: 0.0, y: 0.0)

                            }
                        

                        ZStack {
                            ZStack {
                                Button(action: {
                                    if self.appliedForce < 110 {
                                        self.appliedForce += 10
                                        if self.appliedForce >= 110 {
                                            soundPlayer.play(withURL: soundWin.getURL())

                                            self.completed = true
                                        }
                                    }
                                    self.isUFOAnimating = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        self.isUFOAnimating = false
                                    }
                                }) {
                                    Image("ufo")
                                        .resizable()
                                        .frame(width: 500, height: 500)
                                        .scaleEffect(isUFOAnimating ? 1.05 : 1.0)
                                        .animation(isUFOAnimating ? vibrationAnimation : .none, value: isUFOAnimating)
                                }
                                .animation(floatAnimation)

                                                    Image("asteroid")
                                                        .resizable()
                                                        .frame(width: 250, height: 250)
                                                        .padding(.leading,300)
                                                        .offset(x: completed ? -asteroidOffset : 0) //
                                                        .animation(completed ? .easeInOut(duration: 4) : floatAnimation, value: completed)

                                                    
                                                    Image("asteroid")
                                                        .resizable()
                                                        .frame(width: 250, height: 250)
                                                        .padding(.trailing,300)
                                                        .offset(x: completed ? asteroidOffset : 0)
                                                        .animation(completed ? .easeInOut(duration: 4) : floatAnimation, value: completed)
                            }
                            
                        }
                    }
                    VStack {
                        Text("FUERZA APLICADA")
                            .font(.custom("digitalism", size: 40))
                            .foregroundColor(completed ? .completedColor : .white)
                            .shadow(color: completed ? .completedColor : .white, radius: 10, x: 0.0, y: 0.0)

                        Text("\(appliedForce)")
                            .font(.custom("digitalism", size: baseFontSize + CGFloat(appliedForce - 10)))
                            .foregroundColor(completed ? .completedColor : .white)
                            .shadow(color: completed ? .completedColor : .white, radius: 10, x: 0.0, y: 0.0)
                    }
                    .padding(.top, 900)
                }
                if nav {
                FullPlanetView() .onAppear{
                        self.soundPlayer.play(withURL: soundMenu   .getURL())
                    }
                }
            }

            if dialogOpacity > 0 {
                PE1DialogExpandable(currentContentIndex: $currentContentIndex, dialogOpacity: $dialogOpacity)
            }
        }
        .onAppear {
            withAnimation(self.floatAnimation) {
            }
            
            if completed == true {
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
    PhysicsEx2View()
}
