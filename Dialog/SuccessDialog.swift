import SwiftUI

struct SuccessDialog: View {
   
    var onContinue: () -> Void

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
                        Text("Seguir explorando")
                            .font(.custom("Montserrat", size: 20))
                            .bold()
                            .foregroundColor(.white)
                    )
                    .onTapGesture {
                        onContinue()
                    }
                    .padding(.trailing, 20)
            }
        }
        .frame(width: 500, height: 100)
    }
}

struct SuccessDialog_Previews: PreviewProvider {
    static var previews: some View {
        SuccessDialog(onContinue: { print("Seguir explorando") })
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

