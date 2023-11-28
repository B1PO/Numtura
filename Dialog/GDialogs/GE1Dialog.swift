import SwiftUI

struct GE1DialogExpandable: View {
    @State private var currentDialog = 0
    @State private var isValidated = false
    @Binding var currentContentIndex: Int
    @Binding var dialogOpacity: Double
    
    let dialogs: [Text] = [
        Text("¡Oh no! Tu viaje por planeta está siendo difícil por la gran cantidad de ").foregroundColor(.black) + Text("basura espacial").bold().foregroundColor(.figuresColor),
        Text("Despeja tu camino eliminando la basura que encuentres con forma parecida").foregroundColor(.black),
        Text(". . .").bold().foregroundColor(.figuresColor)
        
    ]

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image("alien")
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
                arrowButton(imageName: currentDialog == 0 ? "arrow.dis.p" : "arrow.act.g", isDisabled: currentDialog == 0, rotationDegrees: 180, offset: currentContentIndex == 2 ? -UIScreen.main.bounds.width / 4 : 0) {
                    if currentDialog > 0 {
                        withAnimation {
                            currentDialog -= 1
                            currentContentIndex = currentDialog
                        }
                    }
                }

                // Next arrow
                arrowButton(imageName: (currentDialog == dialogs.count - 1 || (currentDialog == 2 && !isValidated)) ? "arrow.dis.p" : "arrow.act.g", isDisabled: currentDialog == dialogs.count - 1 || (currentDialog == 2 && !isValidated), rotationDegrees: 0, offset: currentContentIndex == 2 ? UIScreen.main.bounds.width / 2 : 0) {
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

struct GE1Dialog: View {
    var body: some View {
        GE1DialogExpandable(currentContentIndex: .constant(0), dialogOpacity: .constant(1.0))
            .padding()
    }
}

struct GE1Dialog_Previews: PreviewProvider {
    static var previews: some View {
        GE1Dialog()
    }
}



