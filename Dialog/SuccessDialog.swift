import SwiftUI

struct SuccessDialog: View {
    @Binding var nav: Bool

    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.white)
                .frame(width: 700, height: 100)
                .shadow(radius: 10)
            
            HStack {
                HStack(spacing: 8) {
                    Image("trophy-star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.yellow)
                        .padding()
                    
                    Text("¡Aventura finalizada!")
                        .foregroundColor(.successBtnColor)
                        .font(.custom("Montserrat", size: 20))
                        .bold()
                }
                .padding(.leading, 20)
                
                Spacer()
                
                // Este RoundedRectangle actúa como botón
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.successBtnColor)
                    .frame(width: 300, height: 75)
                    .overlay(
                        HStack {
                            Text("Seguir explorando")
                                .font(.custom("Montserrat", size: 20))
                                .bold()
                            .foregroundColor(.white)
                            Image("arrow-success")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding(.trailing, -40)
                        }
                    )
                    .onTapGesture {
                        // Llamamos al cierre con un valor booleano (true)
                        nav = true
                    }
                    .padding(.trailing, 20)
            }
        }
        .frame(width: 500, height: 100)
    }
}

struct SuccessDialog_Previews: PreviewProvider {
    static var previews: some View {
        let nav = Binding<Bool>(
            get: { return false },
            set: { _ in }
        )
        
        return SuccessDialog(nav: nav)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
