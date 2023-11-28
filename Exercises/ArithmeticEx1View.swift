import SwiftUI
import AVKit
class SharedData: ObservableObject {
    @Published var resultValue: Bool = false
}

struct ArithmeticEx1View: View {
    @State private var stars: [Starrr] = []
    @State private var completed = false
    @State var nav: Bool = false
    //Sonidos
    private let soundPlayer = SoundActive()
    let soundWin:SoundModel = .init(name: "soundWin")
    let soundMenu:SoundModel = .init(name: "menuSound")
    
    

    let primeNumbers = [
         2, 3, 5, 7, 11, 13, 17, 19, 23, 29,
         31, 37, 41, 43, 47, 53, 59, 61, 67, 71,
         73, 79, 83, 89, 97, 101, 103, 107, 109, 113,
         127, 131, 137, 139, 149, 151, 157, 163, 167, 173,
         179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
         233, 239, 241
     ]
    var body: some View {
        ZStack {
            VStack {
                if completed {
                    SuccessDialog(nav: $nav)
                        .zIndex(1)
                        .onAppear{
                            soundPlayer.play(withURL: soundWin.getURL())
                        }
                } else {
                    AE1DialogIG()
                        .padding(.bottom, -80)
                        .zIndex(1)
                }

                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 5), spacing: 90) {
                        ForEach(stars.indices, id: \.self) { index in
                            Button(action: {
                                guard !completed else { return }
                                if stars[index].isPrime {
                                    withAnimation {
                                        stars[index].isFadingOut = true
                                        stars[index].isGrayedOut = true
                                        checkCompletion()
                                    }
                                } else {
                                    withAnimation {
                                        resetStars()
                                    }
                                }
                            }) {
                                ZStack {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 97.75))
                                        .foregroundColor(stars[index].isGrayedOut ? .gray : .starsColor)
                                        .shadow(color: stars[index].isGrayedOut ? .gray : .starsColor, radius: 5, x: 0.0, y: 0.0)

                                    Text("\(stars[index].primeNumber)")
                                        .font(.custom("Montserrat", size: 33))
                                        .bold()
                                        .foregroundColor(stars[index].isGrayedOut ? .gray : .starFont)
                                        .padding(.top, 1)
                                }
                                .scaleEffect(stars[index].isFadingOut ? 0.5 : 1.0)
                                .opacity(stars[index].isFadingOut ? 0.5 : 1.0)
                                .animation(.easeInOut(duration: 0.5))
                            }
                            .frame(width: 75, height: 75)
                            .disabled(completed)                         }
                    }
                    .frame(width: 800, height: 1000)
                    .drawingGroup()
                    .zIndex(0)
                }
            }
            .onAppear {
                startGame()
            }.offset(x: nav ? UIScreen.main.bounds.width*0 : UIScreen.main.bounds.width*0  , y: nav ? UIScreen.main.bounds.height * -1 : UIScreen.main.bounds.height * 0)
                .animation(.spring())
            //Fin de ZStack
            if nav {
                menuArim() .onAppear{
                    self.soundPlayer.play(withURL: soundMenu   .getURL())
                }
            }
        }
    }

    func startGame() {
        generateStars()
    }
    
    func generateStars() {
        stars.removeAll()
        var allStars = [Starrr]()
        var primeIndex = 0
        var isNextPrime = true

        while allStars.count < 25 {
            var primeNumber: Int

            if isNextPrime {
                if primeIndex < primeNumbers.count {
                    primeNumber = primeNumbers[primeIndex]
                    primeIndex += 1
                } else {
                    repeat {
                        primeNumber = Int.random(in: 4...100)
                    } while primeNumber % 2 != 0
                }
            } else {
                repeat {
                    primeNumber = Int.random(in: 4...100)
                } while primeNumber % 2 != 0
            }

            let x = CGFloat.random(in: 0..<5) * 75
            let y = CGFloat.random(in: 0..<5) * 75

            let newStar = Starrr(isPrime: isNextPrime, primeNumber: primeNumber, x: x, y: y)
            allStars.append(newStar)
            isNextPrime.toggle()
            
        }

        stars = allStars.shuffled()
    }


    func checkCompletion() {
        if stars.filter({ $0.isPrime && !$0.isFadingOut }).isEmpty {
            completed = true
        }
    }

    func resetStars() {
        for index in stars.indices {
            stars[index].isFadingOut = false
            stars[index].isGrayedOut = false
        }
    }
}

struct ArithmeticEx1View_Previews: PreviewProvider {
    static var previews: some View {
        ArithmeticEx1View()
    }
}

struct Starrr: Identifiable {
    var id = UUID()
    var isPrime: Bool
    var primeNumber: Int
    var x: CGFloat
    var y: CGFloat
    var isFadingOut: Bool = false
    var isGrayedOut: Bool = false
}

