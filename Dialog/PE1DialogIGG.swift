//
//  PE1DialogIGG.swift
//  Numtura
//
//  Created by Michelle Ayala on 22/11/23.
//

import SwiftUI

struct PE1DialogIGG: View {
    @State private var isExpanded = true
    @State private var currentDialog = 0
    @State private var isValidated = false

    let dialogs: [Text] = [
                Text("Elimina los pares de figuras semejantes que encuentres, solo pulsa sobre ellas."),
                Text("Recuerda que dos figuras geométricas son  ") + Text(" semejantes").bold().foregroundColor(.planet2C2) + Text(" si tienen la misma forma sin importar los tamaños entre ellas.")
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
                        Image(currentDialog == 0 ? "arrow.dis.p" : "arros.act.g")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .offset(x : 3)
                            .rotationEffect(.degrees(180))
                    }
                    Image("alien")
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
                            Image((currentDialog == dialogs.count - 1 || (currentDialog == 3 && !isValidated)) ? "arrow.dis.p" : "arros.act.g")
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

#Preview {
    PE1DialogIGG()
}
