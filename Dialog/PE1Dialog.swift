import SwiftUI

struct PE1DialogExpandable: View {
    @State private var isExpanded = true
    @State private var currentDialog = 0
    @State private var isValidated = false 
    
    let dialogs: [Text] = [
        Text("beep-boop beep-boop"),
        Text("¡Te has encontrado con la nave misteriosa! ").foregroundColor(.planet1C2) + Text("Está atascada y el único que puede ayudarla para que continúe su camino, eres tu."),
        Text("Es necesario aplicar una") + Text(" fuerza ") .bold() .foregroundColor(.planet1C2) + Text("sobre ella..."),
        Text("Presiona la nave hasta obtener la fuerza necesaria para salir.").foregroundColor(.planet1C2),
        Text("¡Buen trabajo viajero! ").foregroundColor(.planet1C2) + Text(" Los datos que usaste para salvar a la nave fueron:") + Text("\n\n") + Text("Formula.").foregroundColor(.planet1C2)
    ]
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                
                HStack(spacing: 10) {
                    Image("robot")
                        .resizable()
                        .scaledToFit()
                        .frame(width: isExpanded ? 140 : 100)
                    
                    if isExpanded {
                        dialogs[currentDialog]
                            .font(.custom("Montserrat", size: 24))
                            .frame(width: 550)
                        
                    }
                }
                .padding(30)
                
                .background(RoundedRectangle(cornerRadius: 50).fill(Color.white))
                
                HStack (spacing: 550, content: {
                                    Button(action: {
                                        if currentDialog > 0 {
                                            withAnimation {
                                                currentDialog -= 1
                                            }
                                        }
                                    }) {
                                        Image("arrow")
                                            .resizable()
                                            .font(.title)
                                            .foregroundColor(currentDialog == 0 ? .gray : .white)
                                            .padding()
                                            .frame(width: 60, height: 60)
                                            .rotationEffect(.degrees(180))
                                            .background(Circle().strokeBorder(Color.white, lineWidth: 4)
                                            .opacity(currentDialog == 0 ? 0.5 : 1.0))
                                    }
                                    .disabled(currentDialog == 0)
                                    .opacity(currentDialog == 0 ? 0.4 : 1)
                                    
                                    // ... Otros elementos de tu HStack ...
                                    
                                    Button(action: {
                                        isExpanded = true
                                        if currentDialog < dialogs.count - 1 {
                                            if currentDialog == 3 && !isValidated {
                                                // Handle validation
                                            } else {
                                                withAnimation {
                                                    currentDialog += 1
                                                }
                                            }
                                        }
                                    }) {
                                        Image( "arrow")
                                            .resizable()
                                            .font(.title)
                                            .foregroundColor((currentDialog == dialogs.count - 1 || (currentDialog == 3 && !isValidated)) ? .gray : .white)
                                            .padding()
                                            .frame(width: 60, height: 60)
                                            .background(Circle().strokeBorder(Color.white, lineWidth: 4).opacity((currentDialog == dialogs.count - 1 || (currentDialog == 3 && !isValidated)) ? 0.5 : 1.0))
                                    }
                                    .disabled(currentDialog == dialogs.count - 1 || (currentDialog == 3 && !isValidated))
                                    .opacity((currentDialog == dialogs.count - 1 || (currentDialog == 3 && !isValidated)) ? 0.4 : 1)
                                })
                                .padding()
                

                

                
                Button("Toggle Validation") {
                    isValidated.toggle()
                }
            }
        }
    }
}

struct PE1Dialog: View {
    var body: some View {
        PE1DialogExpandable()
            .padding()
    }
}


struct PE1Dialog_Previews: PreviewProvider {
    static var previews: some View {
        PE1Dialog()
    }
}

