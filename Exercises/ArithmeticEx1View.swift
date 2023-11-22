import SwiftUI

struct ArithmeticEx1View: View {
    @State private var score = 0
    @State private var timeRemaining = 30
    @State private var isGameActive = false
    @State private var stars: [Starrr] = []

    let primeNumbers = [
        2, 3, 5, 7, 11, 13, 17, 19, 23, 29,
        31, 37, 41, 43, 47, 53, 59, 61, 67, 71,
        73, 79, 83, 89, 97, 101, 103, 107, 109, 113,
        127, 131, 137, 139, 149, 151, 157, 163, 167, 173,
        179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
        233, 239, 241
    ]

    @State private var isShowingMenu = false // Variable para controlar la visualización del menú

    var body: some View {
        ZStack {
            BackgroundView()
                .zIndex(0)

            VStack {
                Text("Puntuación: \(score)")
                    .font(.system(size: 40))
                    .foregroundColor(.white)

                if isGameActive {
                    Text("Tiempo Restante: \(timeRemaining)")
                        .font(.title)
                        .foregroundColor(.white)
                        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                                if stars.filter({ $0.isPrime && !$0.isFadingOut }).isEmpty {
                                    endGame()
                                }
                            } else {
                                endGame()
                            }
                        }

                    LazyVGrid(columns: Array(repeating: GridItem(), count: 5),spacing: 90) {
                        ForEach(stars.indices, id: \.self) { index in
                            Button(action: {
                                if stars[index].isPrime {
                                    if !stars[index].isFadingOut {
                                        score += 1
                                        withAnimation {
                                            stars[index].isFadingOut = true
                                            stars[index].isGrayedOut = true
                                        }
                                        if stars.filter({ $0.isPrime && !$0.isFadingOut }).isEmpty {
                                            endGame()
                                        }
                                    }
                                } else {
                                   
                                }
                            }) {
                                ZStack {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 97.75))
                                        .foregroundColor(stars[index].isGrayedOut ? .gray : .yellow)
                                    Text("\(stars[index].primeNumber)")
                                        .font(.title)
                                        .foregroundColor(.primary) // Cambia el color del texto a negro
                                }
                                .scaleEffect(stars[index].isFadingOut ? 0.5 : 1.0)
                                .opacity(stars[index].isFadingOut ? 0.5 : 1.0)
                                .animation(.easeInOut(duration: 0.5))
                            }
                            .frame(width: 75, height: 75) // Ajusta el tamaño de las estrellas
                        }
                    }
                    .frame(width: 800, height: 1000)
                    .drawingGroup()

                    // Botón para volver al menú
    
                    
                } else {
                    
                    Text("").padding().padding()
                    Button("Comenzar Juego") {
                        score = 0
                        timeRemaining = 30
                        isGameActive = true
                        generateStars()
                    }
                    .font(.system(size: 40))
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.secondary)
                    
                    Text("").padding().padding()
                    
                    Button("Volver al Menú") {
                                       isShowingMenu.toggle()
                                   }
                    .font(.system(size: 40))
                                   .padding()
                                   .foregroundColor(Color.white)
                                   .background(Color.secondary)
                                   .fullScreenCover(isPresented: $isShowingMenu, content: {
                                       StarEx1View()
                                   })
                }
            }
        }
    }

    func generateStars() {
        stars.removeAll()
        var allStars = [Starrr]()
        var primeIndex = 0
        var isNextPrime = true

        while allStars.count < 25 {
            var primeNumber: Int

            if isNextPrime {
                // Si todavía hay números primos disponibles en la lista, selecciona uno.
                if primeIndex < primeNumbers.count {
                    primeNumber = primeNumbers[primeIndex]
                    primeIndex += 1
                } else {
                    // Si no quedan números primos disponibles, cambia a números pares aleatorios (excluyendo el 2).
                    repeat {
                        primeNumber = Int.random(in: 4...100)
                    } while primeNumber % 2 != 0
                }
            } else {
                // Siempre selecciona números pares (excluyendo el 2) cuando no sea un número primo.
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

    func endGame() {
        isGameActive = false
        
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
