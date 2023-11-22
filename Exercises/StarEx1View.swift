import SwiftUI

struct StarEx1View: View {
    @State private var dialogIndex = 0

    var dialogTexts = [
        "Hola compañero",
        "Como buen astronauta",
        "Haz de conocer los números primos",
        "Vamos a ver qué tan bueno eres identificándolos",
        "Hay algunos perdidos en las estrellas",
        "Recuerda:",
        "Los números primos son números naturales",
        "Que solo son divisibles entre ellos mismos y el uno",
        "Que comience la aventura"
    ]

    @State private var isDialogComplete = false
    @State private var isGameStarted = false
    @State private var pulsate = false // Variable para la animación del planeta

    var body: some View {
        ZStack {
            BackgroundView()
                .zIndex(0)

            // El planeta se coloca aquí y se anima para pulsar
            Image("arim_planeta")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 900, height: 900)
                .scaleEffect(pulsate ? 1.05 : 1.0)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        pulsate.toggle()
                    }
                }
                .zIndex(1) // El planeta está detrás de los botones
                .offset(y: 400) // Posición actual del planeta
            ZStack {
                          
                          Image(systemName: "star.fill")
                              .resizable()
                              .foregroundColor(.yellow)
                              .frame(width: 60, height: 60)
                              .offset(x: -300, y: -200)
                
                    Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 60, height: 60)
                    .offset(x: -30, y: -450)
                
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 60, height: 60)
                    .offset(x: 80, y: -300)
                         
                          Image(systemName: "star.fill")
                              .resizable()
                              .foregroundColor(.yellow)
                              .frame(width: 60, height: 60)
                              .offset(x: -180, y: -350)
                          
                          Image(systemName: "star.fill")
                              .resizable()
                              .foregroundColor(.yellow)
                              .frame(width: 60, height: 60)
                              .offset(x: -50, y: -180)
                          
                          Image(systemName: "star.fill")
                              .resizable()
                              .foregroundColor(.yellow)
                              .frame(width: 60, height: 60)
                              .offset(x: 320, y: -290)
                
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 60, height: 60)
                    .offset(x: 160, y: -140)
                          
                          Image(systemName: "star.fill")
                              .resizable()
                              .foregroundColor(.yellow)
                              .frame(width: 60, height: 60)
                              .offset(x: 190, y: -390)
                      }
                      .zIndex(2) // Asegúrate de que las estrellas estén por encima del planeta


            VStack(spacing: 0) {
                Spacer()

                // Contenido de los diálogos o de la pantalla de juego
                if isDialogComplete {
                    Image("astronaut")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 450, height: 450)
                        .padding(.bottom, 20) // Agrega espacio debajo del mono

                    // Botón Jugar
                    Button("Jugar") {
                        isGameStarted = true
                    }
                    .font(.system(size: 60))
                    .padding()
                    .background(Color.secondary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .zIndex(3) // Asegúrate de que el botón esté encima del planeta
                    .padding(.top, 20) // Agrega espacio en la parte superior para bajar los botones
                } else {
                    ComicChatBubble(text: dialogTexts[dialogIndex])
                        .padding(.horizontal)
                    
                    // Botón Siguiente
                    Button("Siguiente") {
                        if dialogIndex < dialogTexts.count - 1 {
                            dialogIndex += 1
                        } else {
                            isDialogComplete = true
                        }
                    }
                    .font(.system(size: 40))
                    .foregroundColor(Color.white)
                    .background(Color.secondary)
                    .cornerRadius(10)
                    .padding()
                    .zIndex(3) // Asegúrate de que el botón esté encima del planeta
                }

                Spacer()
            }
            .zIndex(2) // Asegúrate de que el VStack esté encima del planeta
            .offset(y: 260) // Ajusta la posición vertical del VStack para que los botones estén más abajo

            .fullScreenCover(isPresented: $isGameStarted, content: {
                ArithmeticEx1View()
            })
        }
    }
}

struct StarEx1View_Previews: PreviewProvider {
    static var previews: some View {
        StarEx1View()
    }
}

struct ComicChatBubble: View {
    let text: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(text)
                    .foregroundColor(.red)
                    .font(.system(size: 35))
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 70).fill(Color.white))
                Spacer()
            }
            // No necesitas verificar contra dialogTexts.last aquí ya que no hay referencia al arreglo
            Image("astronaut")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
    }
}
