import SwiftUI

struct AE1DialogExpandable: View {
    @State private var currentDialog = 0
    @State private var isValidated = false
    @Binding var currentContentIndex: Int
    @Binding var dialogOpacity: Double
    
    let dialogs: [Text] = [
        Text("¡Hola, compañero!").foregroundColor(.planet3C2),
        Text("Como buen astronauta, has de conocer los") .foregroundColor(.black) + Text(" numeros primos... ").bold().foregroundColor(.planet3C2),
        Text("Veamos qué tan bueno eres identificandolos...").foregroundColor(.black),
        Text("Hay algunos ").foregroundColor(.black) + Text("perdidos entre las estrellas").foregroundColor(.planet3C2) + Text(" y tenemos que encontrarlos.").foregroundColor(.black),
        Text(". . .").bold().foregroundColor(.planet3C2),
    ]

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image("astronaut")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)

                dialogs[currentDialog]
                    .font(.custom("Montserrat", size: 24))
                    .frame(width: 550)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
            .opacity(dialogOpacity)
            .rotationEffect(.degrees(currentContentIndex == 4 ? 45 : 0))
            .offset(y: currentContentIndex == 4 ? -UIScreen.main.bounds.height / 2 : 0)
            .animation(currentContentIndex == 4 ? .easeInOut(duration: 2) : .default, value: currentContentIndex)

            HStack(alignment: .center, spacing: 550) {
                // Previous arrow
                arrowButton(imageName: currentDialog == 0 ? "arrow.dis.p" : "arrow.act.a", isDisabled: currentDialog == 0, rotationDegrees: 180, offset: currentContentIndex == 4 ? -UIScreen.main.bounds.width / 4 : 0) {
                    if currentDialog > 0 {
                        withAnimation {
                            currentDialog -= 1
                            currentContentIndex = currentDialog
                        }
                    }
                }

                // Next arrow
                arrowButton(imageName: (currentDialog == dialogs.count - 1 || (currentDialog == 4 && !isValidated)) ? "arrow.dis.p" : "arrow.act.a", isDisabled: currentDialog == dialogs.count - 1 || (currentDialog == 4 && !isValidated), rotationDegrees: 0, offset: currentContentIndex == 4 ? UIScreen.main.bounds.width / 2 : 0) {
                    if currentDialog < dialogs.count - 1 {
                        withAnimation {
                            currentDialog += 1
                            currentContentIndex = currentDialog
                        }
                    }
                }
            }
            .padding()
            .opacity(dialogOpacity)
        }
        .onChange(of: currentContentIndex) { newIndex in
            if newIndex == 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                    withAnimation(.easeOut(duration: 2)) {
                        dialogOpacity = 0
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func arrowButton(imageName: String, isDisabled: Bool, rotationDegrees: Double, offset x: CGFloat, action: @escaping () -> Void) -> some View {
        ZStack {
            Circle()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
            Image(imageName)
                .resizable()
                .frame(width: 30, height: 30)
                .offset(x: 3)
                .rotationEffect(.degrees(rotationDegrees))
        }
        .offset(x: x)
        .disabled(isDisabled)
        .onTapGesture(perform: action)
    }
}

struct AE1Dialog: View {
    var body: some View {
        AE1DialogExpandable(currentContentIndex: .constant(0), dialogOpacity: .constant(1.0))
            .padding()
    }
}

struct AE1Dialog_Previews: PreviewProvider {
    static var previews: some View {
        StarEx1View()
    }
}



