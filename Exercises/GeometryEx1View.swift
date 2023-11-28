import SwiftUI

struct GeometryEx1View: View {
    
    @State private var dialogOpacity = 1.0
    @State private var completed = false
    @State var nav: Bool = false
    
    @State var opacidad1: Double = 1
    @State var opacidad2: Double = 1
    @State var opacidad3: Double = 1
    @State var opacidad4: Double = 1

    
    @State var pulsadof1: Bool = false
    @State var pulsadof2: Bool = false
    @State var pulsadof3: Bool = false
    @State var pulsadof4: Bool = false
    @State var pulsadof5: Bool = false
    @State var pulsadof6: Bool = false
    @State var pulsadof7: Bool = false
    @State var pulsadof8: Bool = false
    @State var pulsadof9: Bool = false
    @State var pulsadof10: Bool = false
    
    @State var colorCorrect : Color = Color.figuresColor
    @State var defaultColor : Color = Color.figuresColor

    
    @State var resp1: Bool = false
    @State var resp2: Bool = false
    @State var resp3: Bool = false
    @State var resp4: Bool = false
    
    @State var opaCongrats = 1.0
    @State var showCongrats = false
    
    //Sonidos
    private let soundPlayer = SoundActive()
    let soundWin:SoundModel = .init(name: "soundWin")
    let soundMenu:SoundModel = .init(name: "menuSound")
    
    var body: some View {
        ZStack{
                VStack{

                    GE1DialogIG()
                        .padding(.top, -50)
                        .opacity(opaCongrats)

                    
                    HStack{
                        Image("figura1")
                            .resizable()
                            .frame(width: 400, height: 220)
                            .padding(.leading,-25)
                            .padding(.bottom,-70)
                            .rotationEffect(.degrees(10))
                            .opacity(opacidad1)
                            .shadow(color: resp1 ? colorCorrect : defaultColor, radius: pulsadof1 ? 10 : 0)
                            .onTapGesture {
                                
                                pulsadof1 = true
                                if pulsadof1 == true && pulsadof6 == true {
                                    resp1 = true
                                    withAnimation(.spring){
                                        opacidad1 = 0
                                        pulsadof1 = false
                                        pulsadof6 = false
                                    }
                                    checkCongratsMessage()
                                }else if pulsadof1 == true && pulsadof2 == true || pulsadof1 == true && pulsadof3 == true || pulsadof1 == true && pulsadof4 == true || pulsadof1 == true && pulsadof5 == true || pulsadof1 == true && pulsadof7 == true || pulsadof1 == true && pulsadof8 == true || pulsadof1 == true && pulsadof9 == true || pulsadof1 == true && pulsadof10 == true{ //si esta pulsado con el que no es par
                                    
                                    defaultColor = Color.red
                                    //                                    resp1 = false
                                    
                                    withAnimation(.spring()){
                                        pulsadof1 = false
                                        pulsadof2 = false
                                        pulsadof3 = false
                                        pulsadof4 = false
                                        pulsadof5 = false
                                        pulsadof6 = false
                                        pulsadof7 = false
                                        pulsadof8 = false
                                        pulsadof9 = false
                                        pulsadof10 = false
                                    }
                                    defaultColor = Color.figuresColor
                                }
                                
                            }
                        
                        Rectangle()
                            .frame(width: 120, height: 120)
                            .foregroundColor(Color(UIColor(red: 0.65, green: 0.85, blue: 0.56, alpha: 1.00)))
                            .padding(.bottom,-80)
                            .rotationEffect(.degrees(45))
                            .opacity(opacidad2)
                            .shadow(color: resp2 ? colorCorrect : defaultColor, radius: pulsadof2 ? 10 : 0)
                            .onTapGesture {
                                pulsadof2 = true
                                if pulsadof2 == true && pulsadof9 == true {
                                    resp2 = true
                                    withAnimation(.spring){
                                        opacidad2 = 0
                                        pulsadof2 = false
                                        pulsadof9 = false
                                    }
                                    checkCongratsMessage()
                                    
                                }else if pulsadof2 == true && pulsadof1 == true || pulsadof2 == true && pulsadof3 == true || pulsadof2 == true && pulsadof4 == true || pulsadof2 == true && pulsadof5 == true || pulsadof2 == true && pulsadof7 == true || pulsadof2 == true && pulsadof8 == true || pulsadof2 == true && pulsadof6 == true || pulsadof2 == true && pulsadof10 == true{ //si esta pulsado con el que no es par
                                    
                                    defaultColor = Color.red
                                    resp2 = false
                                    
                                    withAnimation(.spring(duration: 1)){
                                        pulsadof1 = false
                                        pulsadof2 = false
                                        pulsadof3 = false
                                        pulsadof4 = false
                                        pulsadof5 = false
                                        pulsadof6 = false
                                        pulsadof7 = false
                                        pulsadof8 = false
                                        pulsadof9 = false
                                        pulsadof10 = false
                                    }
                                    defaultColor = Color.figuresColor
                                }
                                
                            }
                        
                        
                        Image("figura2")
                            .resizable()
                            .frame(width: 380, height: 250)
                            .rotationEffect(.degrees(-28))
                            .padding(.bottom,35)
                            .padding(.leading,-45)
                            .opacity(opacidad3)
                            .shadow(color: resp3 ? colorCorrect : defaultColor, radius: pulsadof3 ? 10 : 0)
                            .onTapGesture {
                                pulsadof3 = true
                                if pulsadof3 == true && pulsadof8 == true {
                                    resp3 = true
                                    withAnimation(.spring){
                                        opacidad3 = 0
                                        pulsadof3 = false
                                        pulsadof8 = false
                                    }
                                    checkCongratsMessage()
                                    
                                }else if pulsadof3 == true && pulsadof1 == true || pulsadof3 == true && pulsadof2 == true || pulsadof3 == true && pulsadof4 == true || pulsadof3 == true && pulsadof5 == true || pulsadof3 == true && pulsadof7 == true || pulsadof3 == true && pulsadof9 == true || pulsadof3 == true && pulsadof6 == true || pulsadof3 == true && pulsadof10 == true{ //si esta pulsado con el que no es par
                                    
                                    defaultColor = Color.red
                                    resp3 = false
                                    
                                    withAnimation(.spring(duration: 1)){
                                        pulsadof1 = false
                                        pulsadof2 = false
                                        pulsadof3 = false
                                        pulsadof4 = false
                                        pulsadof5 = false
                                        pulsadof6 = false
                                        pulsadof7 = false
                                        pulsadof8 = false
                                        pulsadof9 = false
                                        pulsadof10 = false
                                    }
                                    defaultColor = Color.figuresColor
                                }
                            }
                    }
                    
                    HStack{
                        Image("figura4")
                            .resizable()
                            .frame(width: 440, height: 260)
                            .padding(.trailing,20)
                            .shadow(color: .figuresColor, radius: pulsadof4 ? 10 : 0
                            )
                            .onTapGesture {
                                pulsadof4 = true
                                if pulsadof4 == true && pulsadof1 == true || pulsadof4 == true && pulsadof2 == true || pulsadof4 == true && pulsadof3 == true || pulsadof4 == true && pulsadof5 == true || pulsadof4 == true && pulsadof7 == true || pulsadof4 == true && pulsadof8 == true || pulsadof4 == true && pulsadof6 == true || pulsadof4 == true && pulsadof9 == true || pulsadof4 == true && pulsadof10 == true{
                                    
                                    
                                    withAnimation(.spring(duration: 1)){
                                        pulsadof1 = false
                                        pulsadof2 = false
                                        pulsadof3 = false
                                        pulsadof4 = false
                                        pulsadof5 = false
                                        pulsadof6 = false
                                        pulsadof7 = false
                                        pulsadof8 = false
                                        pulsadof9 = false
                                        pulsadof10 = false
                                    }
                                    
                                    checkCongratsMessage()
                                    
                                }
                                
                            }
                        
                        
                        Image("figura3")
                            .resizable()
                            .frame(width: 250, height: 150)
                            .padding(.leading,-90)
                            .opacity(opacidad4)
                            .shadow(color: resp4 ? colorCorrect : defaultColor, radius: pulsadof5 ? 10 : 0
                            )
                            .onTapGesture {
                                pulsadof5 = true
                                if pulsadof5 == true && pulsadof10 == true {
                                    resp4 = true
                                    withAnimation(.spring){
                                        opacidad4 = 0
                                        pulsadof5 = false
                                        pulsadof10 = false
                                    }
                                    checkCongratsMessage()
                                    
                                }else if pulsadof5 == true && pulsadof1 == true || pulsadof5 == true && pulsadof3 == true || pulsadof5 == true && pulsadof4 == true || pulsadof5 == true && pulsadof2 == true || pulsadof5 == true && pulsadof7 == true || pulsadof5 == true && pulsadof8 == true || pulsadof5 == true && pulsadof6 == true || pulsadof5 == true && pulsadof9 == true{ //si esta pulsado con el que no es par
                                    
                                    defaultColor = Color.red
                                    resp4 = false
                                    
                                    withAnimation(.spring(duration: 1)){
                                        pulsadof1 = false
                                        pulsadof2 = false
                                        pulsadof3 = false
                                        pulsadof4 = false
                                        pulsadof5 = false
                                        pulsadof6 = false
                                        pulsadof7 = false
                                        pulsadof8 = false
                                        pulsadof9 = false
                                        pulsadof10 = false
                                    }
                                    defaultColor = Color.figuresColor
                                }
                            }
                        
                        
                        VStack{
                            Image("figura1")
                                .resizable()
                                .frame(width: 255, height: 135)
                                .padding(.leading,-25)
                                .rotationEffect(.degrees(10))
                                .opacity(opacidad1)
                                .shadow(color: resp1 ? colorCorrect : defaultColor, radius: pulsadof6 ? 10 : 0
                                )
                                .onTapGesture {
                                    pulsadof6 = true
                                    if pulsadof1 == true && pulsadof6 == true {
                                        resp1 = true
                                        withAnimation(.spring){
                                            opacidad1 = 0
                                            pulsadof1 = false
                                            pulsadof6 = false
                                        }
                                        checkCongratsMessage()
                                        
                                    }else if pulsadof6 == true && pulsadof2 == true || pulsadof6 == true && pulsadof3 == true || pulsadof6 == true && pulsadof4 == true || pulsadof6 == true && pulsadof5 == true || pulsadof6 == true && pulsadof7 == true || pulsadof6 == true && pulsadof8 == true || pulsadof6 == true && pulsadof9 == true || pulsadof6 == true && pulsadof10 == true{ //si esta pulsado con el que no es par
                                        
                                        defaultColor = Color.red
                                        resp1 = false
                                        
                                        withAnimation(.spring()){
                                            pulsadof1 = false
                                            pulsadof2 = false
                                            pulsadof3 = false
                                            pulsadof4 = false
                                            pulsadof5 = false
                                            pulsadof6 = false
                                            pulsadof7 = false
                                            pulsadof8 = false
                                            pulsadof9 = false
                                            pulsadof10 = false
                                        }
                                        defaultColor = Color.figuresColor
                                    }
                                }
                            
                            Image("figura5")
                                .resizable()
                                .frame(width: 400, height: 220)
                                .padding(.leading,-70)
                                .shadow(color: .figuresColor, radius: pulsadof7 ? 10 : 0
                                )
                                .onTapGesture {
                                    pulsadof7 = true
                                    if pulsadof7 == true && pulsadof1 == true || pulsadof7 == true && pulsadof2 == true || pulsadof7 == true && pulsadof3 == true || pulsadof7 == true && pulsadof5 == true || pulsadof7 == true && pulsadof4 == true || pulsadof7 == true && pulsadof8 == true || pulsadof7 == true && pulsadof6 == true || pulsadof7 == true && pulsadof9 == true || pulsadof7 == true && pulsadof10 == true{
                                        
                                        
                                        withAnimation(.spring(duration: 1)){
                                            pulsadof1 = false
                                            pulsadof2 = false
                                            pulsadof3 = false
                                            pulsadof4 = false
                                            pulsadof5 = false
                                            pulsadof6 = false
                                            pulsadof7 = false
                                            pulsadof8 = false
                                            pulsadof9 = false
                                            pulsadof10 = false
                                        }
                                        checkCongratsMessage()
                                        
                                    }
                                    
                                }
                            
                        }
                        
                    }
                    
                    HStack{
                        Image("figura2")
                            .resizable()
                            .frame(width: 230, height: 120)
                            .rotationEffect(.degrees(30))
                            .opacity(opacidad3)
                            .shadow(color: resp3 ? colorCorrect : defaultColor, radius: pulsadof8 ? 10 : 0)
                            .onTapGesture {
                                pulsadof8 = true
                                if pulsadof3 == true && pulsadof8 == true {
                                    resp3 = true
                                    withAnimation(.spring){
                                        opacidad3 = 0
                                        pulsadof3 = false
                                        pulsadof8 = false
                                    }
                                    checkCongratsMessage()
                                    
                                }else if pulsadof8 == true && pulsadof1 == true || pulsadof8 == true && pulsadof2 == true || pulsadof8 == true && pulsadof4 == true || pulsadof8 == true && pulsadof5 == true || pulsadof8 == true && pulsadof7 == true || pulsadof8 == true && pulsadof9 == true || pulsadof8 == true && pulsadof6 == true || pulsadof8 == true && pulsadof10 == true{ //si esta pulsado con el que no es par
                                    
                                    defaultColor = Color.red
                                    resp3 = false
                                    
                                    withAnimation(.spring(duration: 1)){
                                        pulsadof1 = false
                                        pulsadof2 = false
                                        pulsadof3 = false
                                        pulsadof4 = false
                                        pulsadof5 = false
                                        pulsadof6 = false
                                        pulsadof7 = false
                                        pulsadof8 = false
                                        pulsadof9 = false
                                        pulsadof10 = false
                                    }
                                    defaultColor = Color.figuresColor
                                }
                            }
                        
                        
                        Rectangle()
                            .frame(width: 180, height: 180)
                            .foregroundColor(Color(UIColor(red: 0.65, green: 0.85, blue: 0.56, alpha: 1.00)))
                            .opacity(opacidad2)
                            .shadow(color: resp2 ? colorCorrect : defaultColor, radius: pulsadof9 ? 10 : 0
                            )
                            .onTapGesture {
                                pulsadof9 = true
                                if pulsadof2 == true && pulsadof9 == true {
                                    resp2 = true
                                    withAnimation(.spring){
                                        opacidad2 = 0
                                        pulsadof2 = false
                                        pulsadof9 = false
                                    }
                                    checkCongratsMessage()
                                    
                                }else if pulsadof9 == true && pulsadof1 == true || pulsadof9 == true && pulsadof3 == true || pulsadof9 == true && pulsadof4 == true || pulsadof9 == true && pulsadof5 == true || pulsadof9 == true && pulsadof7 == true || pulsadof9 == true && pulsadof8 == true || pulsadof9 == true && pulsadof6 == true || pulsadof9 == true && pulsadof10 == true{ //si esta pulsado con el que no es par
                                    
                                    defaultColor = Color.red
                                    resp2 = false
                                    
                                    withAnimation(.spring(duration: 1)){
                                        pulsadof1 = false
                                        pulsadof2 = false
                                        pulsadof3 = false
                                        pulsadof4 = false
                                        pulsadof5 = false
                                        pulsadof6 = false
                                        pulsadof7 = false
                                        pulsadof8 = false
                                        pulsadof9 = false
                                        pulsadof10 = false
                                    }
                                    defaultColor = Color.figuresColor
                                }
                            }
                        
                        
                        Image("figura3")
                            .resizable()
                            .frame(width: 180, height: 100)
                            .rotationEffect(.degrees(25))
                            .padding(.top,30)
                            .opacity(opacidad4)
                            .shadow(color: resp4 ? colorCorrect : defaultColor, radius: pulsadof10 ? 10 : 0
                            )
                            .onTapGesture {
                                pulsadof10 = true
                                if pulsadof5 == true && pulsadof10 == true {
                                    resp4 = true
                                    withAnimation(.spring){
                                        opacidad4 = 0
                                        pulsadof5 = false
                                        pulsadof10 = false
                                    }
                                    checkCongratsMessage()
                                    
                                }else if pulsadof10 == true && pulsadof1 == true || pulsadof10 == true && pulsadof3 == true || pulsadof10 == true && pulsadof4 == true || pulsadof10 == true && pulsadof2 == true || pulsadof10 == true && pulsadof7 == true || pulsadof10 == true && pulsadof8 == true || pulsadof10 == true && pulsadof6 == true || pulsadof10 == true && pulsadof9 == true{ //si esta pulsado con el que no es par
                                    
                                    defaultColor = Color.red
                                    resp4 = false
                                    
                                    withAnimation(.spring(duration: 1)){
                                        pulsadof1 = false
                                        pulsadof2 = false
                                        pulsadof3 = false
                                        pulsadof4 = false
                                        pulsadof5 = false
                                        pulsadof6 = false
                                        pulsadof7 = false
                                        pulsadof8 = false
                                        pulsadof9 = false
                                        pulsadof10 = false
                                    }
                                    defaultColor = Color.figuresColor
                                }
                            }
                        
                    }.padding(.bottom,30)
                    

                    HStack{
                        if completed {
                            SuccessDialog(nav: $nav).onAppear{
                                soundPlayer.play(withURL: soundWin.getURL())
                            }
                        }
                    }
                }
                
            
        }.offset(x: nav ? UIScreen.main.bounds.width*0 : UIScreen.main.bounds.width*0  , y: nav ? UIScreen.main.bounds.height * -1 : UIScreen.main.bounds.height * 0)
            .animation(.spring())
        //Fin de ZStack
        if nav {
            
            PlanetViewGeo()
                .onAppear{
                    self.soundPlayer.play(withURL: soundMenu   .getURL())
                }
        }
    }
    
    func checkCongratsMessage() -> Void {
        if(
            resp1 == true &&
            resp2 == true &&
            resp3 == true &&
            resp4 == true
        
        ){
            withAnimation(.spring){
                completed = true
                opaCongrats = 0.0
            }
        }
    }
}

#Preview{
    GeometryEx1View()
}


