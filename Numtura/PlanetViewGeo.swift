

import SwiftUI
import AVKit

class objetos2{
    var nameFile:String
    var w:CGFloat
    var h:CGFloat
    var p:CGFloat
    init(nameFile: String, w: CGFloat, h: CGFloat, p:CGFloat) {
        self.nameFile = nameFile
        self.w = w
        self.h = h
        self.p = p
    }
}
//Clase de mision
class misionObject2{
    var textTittle:String
    var coordenadas:String
    var objeto:objetos2
    var page:String
    init(textTittle: String, coordenadas: String, objeto: objetos2, page: String) {
        self.textTittle = textTittle
        self.coordenadas = coordenadas
        self.objeto = objeto
        self.page=page
    }
    
}

struct PlanetViewGeo: View {
    
    @State private var rotation: Double = 0
    @State private var currentIndex: Int = 0
    @State var nav: Bool = false
    @State var nav2: Bool = false
    @State var indexPrime: Int=0
    let planetsView:[AnyView]=[AnyView(FiguresEx1View()),AnyView(FiguresEx1View()),AnyView(FiguresEx1View()) ]

    
    //objetos de las misiones
    var explosion=objetos2(nameFile: "cupulaVerde", w: 160, h: 165,p:143)
    var fuerzaMist=objetos2(nameFile: "Charge", w: 110, h: 110,p:133)
    var base = objetos2(nameFile: "sat", w: 140, h: 140,p:10)
    let colorBorder:LinearGradient = LinearGradient(colors: [.planet2C2,.planet2C1], startPoint: .topLeading, endPoint: .bottomTrailing)
    //Sonidos
    private let soundPlayer = SoundActive()
    let sound:SoundModel = .init(name: "desplazarSound")
    //misiones
    var m1: misionObject2!
    var m2: misionObject2!
    var m3: misionObject2!
    var misionesList:[misionObject2]!
    init() {
        m1 = misionObject2(textTittle: "BASURA ESPACIAL", coordenadas: "(51° 30' 30'' N; 0° 7' 32'' O)", objeto: explosion, page: "")
        m2 = misionObject2(textTittle: "EL COLECCIONISTA", coordenadas: "(32° 23' 40'' N; 0° 2' 22'' 1)", objeto: fuerzaMist, page: "")
        m3 = misionObject2(textTittle: "SEÑALES ANGULARES", coordenadas: "(25° 22' 52'' N; 2° 5' 25'' 5)", objeto: base, page: "")
        
        misionesList = [m1, m2, m3]
    }

    
    
    var body: some View {
        ZStack{
            BackgroundView()
            
            ZStack {
                VStack{
                    cardInfo2(
                        buttonAction: goBakc,
                        buttonMision: {performAction(index: currentIndex)},
                        mision: misionesList [currentIndex])
                    .padding(.bottom, 800)
                }
                placeView2(objeto:misionesList[currentIndex].objeto)
                VStack{
                    ZStack{
                            Image("geoPlanet")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 1140, height: 1140)
                                .rotationEffect(Angle.degrees(90), anchor: .center)
                                .animation(.interactiveSpring(duration: 0.1))
                            Circle()
                                .stroke(colorBorder, lineWidth: 13)
                                .frame(width: 1080, height: 1100)
                                .shadow(color: .planet2C2, radius: 16, x: 0, y: 0)
                        /*mage(estacionDajo.nameFile)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                                .padding(.bottom, 1440)*/
                        
                    }.rotationEffect(Angle.degrees(rotation))
                        .padding(.bottom, -1000)
                        .gesture(
                            DragGesture(minimumDistance: 5, coordinateSpace: .local)
                                .onEnded { value in
                                    withAnimation {
                                        rotation += value.translation.width > 0 ? 120 : -120
                                        updateCurrentMission()
                                    }
                                }
                                .onChanged{ _ in
                                    self.soundPlayer.play(withURL: sound.getURL())
                                }
                        )
                }.padding(.top,500)
            }.offset(x: nav ? UIScreen.main.bounds.width*0 : UIScreen.main.bounds.width*0  , y: nav ? UIScreen.main.bounds.height * -1 : UIScreen.main.bounds.height * 0)
                .animation(.spring())
            //Fin de ZStack
            if nav {
                PlanetView()
            }
            if nav2 {
                planetsView[indexPrime]
            }
        }
    }
    private func updateCurrentMission() {
        let totalMissions = misionesList.count
        let missionAngle = 360.0 / Double(totalMissions)
        let direction: Double = rotation > 0 ? 1 : -1
        let normalizedRotation = (rotation * direction + 360).truncatingRemainder(dividingBy: 360)
        let newIndex = Int(normalizedRotation / missionAngle)
        currentIndex = newIndex
        rotation = Double(newIndex) * missionAngle * direction
    }
    func goBakc(){
        self.nav.toggle()
    }
    func performAction(index: Int) {
        
        print("Acción para la tarjeta \(index)")
        print("Redirigiendo a otra vista para la tarjeta \(index)")
        self.nav2.toggle()
        self.indexPrime=index
    }//Fin de funcion
}
struct cardInfo2:View{
   // var coordenadas:String
    //var titulo:String
    var buttonAction: () -> Void
    var buttonMision: () -> Void

    var mision: misionObject2
    let gradient: LinearGradient = LinearGradient(colors: [.black, .planet2C2,], startPoint: .top, endPoint: .bottom)
    let colorBorder:LinearGradient = LinearGradient(colors: [.planet2C2, .planet2C1,], startPoint: .topLeading, endPoint: .bottomTrailing)
    let border:CGFloat=60.0
    //Variables de sonido
    private let soundPlayer = SoundActive()
    let soundBack:SoundModel = .init(name: "backSound")
    let soundStart:SoundModel = .init(name: "iniciarSound")
   
    func holaMundo(){
        print("Hola mundo")
    }
    var body: some View{
        ZStack{
            Rectangle()
                .fill(gradient.opacity(0.7))
                .blur(radius: 7)
                .frame(width: 700, height: 340)
                .cornerRadius(border)
                .overlay(
                    RoundedRectangle(cornerRadius: border)
                        .stroke(colorBorder, lineWidth: 10) // Cambia el color y el ancho del borde según tus preferencias
                )
            Rectangle()
                .fill(Color.black.opacity(0.6))
                .frame(width: 700, height: 340)
                .cornerRadius(border)
               
            VStack{
                Text(mision.coordenadas)
                    .font(.custom("Montserrat", size: 20))
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 5, x: 0, y: 0)
                    .padding(.top, 25)
                
                Text(mision.textTittle)
                    .font(.custom("Montserrat", size: 50))
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 5, x: 0, y: 0)
                    .padding(.top, 10)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 300, height: 2)
                
                HStack {
                    Button {
                        self.soundPlayer.play(withURL: soundBack.getURL())
                        buttonAction()
                    } label: {
                        Text("MENÚ")
                            .font(.custom("Montserrat", size: 20))
                            .foregroundColor(.black)
                            .padding(.trailing, 40)
                            .padding(.leading, 40)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(40)
                    } //Fin de boton
                    Button(action: {
                        buttonMision()
                        self.soundPlayer.play(withURL: soundStart.getURL())
                    }, label: {
                        Text("INICIAR")
                            .font(.custom("Montserrat", size: 20))
                            .foregroundColor(.black)
                            .padding(.trailing, 40)
                            .padding(.leading, 40)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(40)
                    })//Fin de Boton
                }.padding(.top,30)
                //Fin de HStack
            }
            
                
        }
    }
}
struct placeView2:View{
    let objeto:objetos2
    var body: some View{
        ZStack{
            Image(objeto.nameFile).resizable().frame(width: objeto.w, height: objeto.h).padding(.top,objeto.p)
        }.frame(width: 300,height: 400).padding(.bottom,-160)
    }
}

struct PlanetViewGeo_Previews: PreviewProvider {
    static var previews: some View {
        PlanetViewGeo()
    }
}
