//import SwiftUI
//
//struct TypingTextView: View {
//    let textToDisplay: String
//    @State private var displayedText: String = ""
//    @State private var textIndex: Int = 0
//
//    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//
//    var body: some View {
//        VStack {
//            Text(displayedText)
//                .onReceive(timer) { _ in
//                    if textIndex < textToDisplay.count {
//                        displayedText.append(textToDisplay[textToDisplay.index(textToDisplay.startIndex, offsetBy: textIndex)])
//                        textIndex += 1
//                    } else {
//                        timer.upstream.connect().cancel()
//                    }
//                }
//        }
//        .onAppear {
//            displayedText = ""
//            textIndex = 0
//        }
//    }
//}
//
//struct TypingTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        TypingTextView(textToDisplay: "¡Es tiempo de carrera espacial!  Tu misión será calcular la velocidad de tu cohete para poder ganar la carrera y llegar en primer lugar")
//    }
//}
//



//-----------------------------------------------------------------------------------------------------------------------
//import SwiftUI
//
//struct JustifiedTextView: UIViewRepresentable {
//    let text: String
//    let colorKeywords: [String]
//    let boldKeywords: [String]
//    let keywordColor: UIColor
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.isEditable = true
//        textView.isScrollEnabled = false
//        textView.backgroundColor = .clear
//
//        let attributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont(name: "Montserrat", size: 20) ?? UIFont.systemFont(ofSize: 20)])
//
//        for keyword in colorKeywords {
//            let range = (text as NSString).range(of: keyword, options: .caseInsensitive)
//            attributedString.addAttribute(.foregroundColor, value: keywordColor, range: range)
//        }
//
//        for keyword in boldKeywords {
//            let range = (text as NSString).range(of: keyword, options: .caseInsensitive)
//            if let boldFont = UIFont(name: "Impact", size: 20) {
//                attributedString.addAttribute(.font, value: boldFont, range: range)
//            }
//        }
//
//        textView.attributedText = attributedString
//        textView.textAlignment = .justified
//        textView.textContainerInset = UIEdgeInsets.zero
//        textView.sizeToFit() // Ajustar al tamaño del contenido
//
//        return textView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        uiView.setContentOffset(.zero, animated: false)
//    }
//
//    typealias UIViewType = UITextView
//}
//
//struct Test: View {
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                Color.green
//                JustifiedTextView(text: "Párrafo de ejemplo donde algunas palabras clave como ejemplo",
//                                  colorKeywords: ["ejemplo", "palabras"],
//                                  boldKeywords: ["Párrafo", "resaltadas"],
//                                  keywordColor: .red)
//                    .padding(20)
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//        }
//    }
//}
//
//struct Test_Previews: PreviewProvider {
//    static var previews: some View {
//        Test()
//    }
//}

import SwiftUI

struct ExpandableView: View {
    @State private var isExpanded = false
    @State private var showText = false
    @Namespace private var animationNamespace

    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                Image("astronaut")
                    .resizable()
                    .scaledToFit()
                    .frame(width: isExpanded ? 140 : 100)
                    .matchedGeometryEffect(id: "image", in: animationNamespace)
                
                if isExpanded {
                    Text("Este es el texto que quieres mostrar.")
                        .font(.custom("Montserrat", size: 20))
                        .opacity(showText ? 1.0 : 0.0)  // Controlar la opacidad según el estado
                        .transition(.move(edge: .trailing))
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        showText = isExpanded ? true : false
                    }
                }
            }
        }
    }
}

struct Test: View {
    var body: some View {
        ExpandableView()
            .padding()
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
