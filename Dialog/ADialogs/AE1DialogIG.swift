import SwiftUI

struct AE1DialogIGExpandable: View {
    @State private var isExpanded = true
    @State private var currentDialog = 0
    @State private var isValidated = false

    let dialogs: [Text] = [
        Text("Presiona todas las estrellas que contengan").foregroundColor(.black) + Text (" números primos.").foregroundColor(.planet3C2).bold(),
        Text("Los números primos") .foregroundColor(.planet3C2).bold() + Text(" son números enteros mayores a uno que solamente se pueden dividir entre uno y ellos mismos.").foregroundColor(.black)
    ]

    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .opacity(currentDialog == 0 ? 0.5 : 1.0)
                            .onTapGesture {
                                if currentDialog > 0 {
                                    withAnimation {
                                        currentDialog -= 1
                                    }
                                }
                            }
                        Image(currentDialog == 0 ? "arrow.dis.p" : "arrow.act.a")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .offset(x : 3)
                            .rotationEffect(.degrees(180))
                    }
                    Image("astronaut")
                        .resizable()
                        .scaledToFit()
                        .frame(width: isExpanded ? 100 : 100)

                    if isExpanded {
                        dialogs[currentDialog]
                            .font(.custom("Montserrat", size: 20))
                            .frame(width: 400)
                        
                        ZStack {
                            Circle()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                                .opacity((currentDialog == dialogs.count - 1 || (currentDialog == 3 && !isValidated)) ? 0.5 : 1.0)
                                .onTapGesture {
                                    if currentDialog < dialogs.count - 1 {
                                        withAnimation {
                                            currentDialog += 1
                                        }
                                    }
                                }
                            Image((currentDialog == dialogs.count - 1 || (currentDialog == 3 && !isValidated)) ? "arrow.dis.p" : "arrow.act.a")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .offset(x : 3)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
            }
        }
    }
}

struct AE1DialogIG: View {
    var body: some View {
        AE1DialogIGExpandable()
            .padding()
    }
}

struct AE1DialogIG_Previews: PreviewProvider {
    static var previews: some View {
        AE1DialogIG()
    }
}





