//
//  ArimDialogView.swift
//  Numtura
//
//  Created by Daniel Ruis on 19/11/23.
//

import SwiftUI

struct ArimDialogView: View {
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
        ZStack{
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
            }
        }
    }
}

#Preview {
    ArimDialogView()
}
