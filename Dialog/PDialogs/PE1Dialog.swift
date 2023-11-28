import SwiftUI

struct PE1DialogExpandable: View {
    @State private var currentDialog = 0
    @State private var isValidated = false
    @Binding var currentContentIndex: Int
    @Binding var dialogOpacity: Double
    
    let dialogs: [Text] = [
        Text("¡Te has encontrado con la nave misteriosa! ").foregroundColor(.planet1C2) + Text("Está atascada y el único que puede ayudarla para que continúe su camino, eres tú.").foregroundColor(.black),
        Text("Es necesario aplicar una").foregroundColor(.black) + Text(" fuerza ").bold().foregroundColor(.planet1C2) + Text("sobre ella...").foregroundColor(.black),
        Text(". . . ").bold().foregroundColor(.planet1C2)
    ]

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image("robot")
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
            .rotationEffect(.degrees(currentContentIndex == 2 ? 45 : 0))
            .offset(y: currentContentIndex == 2 ? -UIScreen.main.bounds.height / 2 : 0)
            .animation(currentContentIndex == 2 ? .easeInOut(duration: 2) : .default, value: currentContentIndex)

            HStack(alignment: .center, spacing: 550) {
                // Previous arrow
                arrowButton(imageName: currentDialog == 0 ? "arrow.dis.p" : "arrow.act.p", isDisabled: currentDialog == 0, rotationDegrees: 180, offset: currentContentIndex == 2 ? -UIScreen.main.bounds.width / 2 : 0) {
                    if currentDialog > 0 {
                        withAnimation {
                            currentDialog -= 1
                            currentContentIndex = currentDialog
                        }
                    }
                }

                // Next arrow
                arrowButton(imageName: (currentDialog == dialogs.count - 1 || (currentDialog == 3 && !isValidated)) ? "arrow.dis.p" : "arrow.act.p", isDisabled: currentDialog == dialogs.count - 1 || (currentDialog == 3 && !isValidated), rotationDegrees: 0, offset: currentContentIndex == 2 ? UIScreen.main.bounds.width / 2 : 0) {
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
            if newIndex == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                    withAnimation(.easeOut(duration: 3)) {
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

struct PE1Dialog: View {
    var body: some View {
        PE1DialogExpandable(currentContentIndex: .constant(0), dialogOpacity: .constant(1.0))
            .padding()
    }
}

struct PE1Dialog_Previews: PreviewProvider {
    static var previews: some View {
        PhysicsEx2View()
    }
}

