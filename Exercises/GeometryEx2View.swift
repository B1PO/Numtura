import SwiftUI

struct DraggablePoint: View {
    @Binding var position: CGPoint
    var snapToPosition: CGPoint
    let diameter: CGFloat = 30
    let snapDistance: CGFloat = 30
    @Binding var isCompleted: Bool
    

    var body: some View {
           Circle()
               .frame(width: diameter, height: diameter)
               .foregroundColor(.white)
               .position(position)
               .gesture(
                   isCompleted ? nil : DragGesture()
                       .onChanged { value in
                           self.position = value.location
                           if abs(self.position.x - snapToPosition.x) < snapDistance &&
                               abs(self.position.y - snapToPosition.y) < snapDistance {
                               self.position = snapToPosition
                           }
                           self.isCompleted = self.position == snapToPosition
                       }
               )
       }
}

struct LengthIndicator: View {
    var value: CGFloat
    var label: String
    var isCompleted: Bool

    var body: some View {
        Text("\(label)= \(String(format: "%.1f", value/100))")
            .font(.custom("Montserrat", size: 30))
            .bold()
            .foregroundColor(.white)
            .shadow(color: .white, radius: 10, x: 0.0, y: 0.0)
            .opacity(isCompleted ? 1 : 0)
            .animation(.easeIn)
    }
}


struct GameView: View {
    @State private var pointA = CGPoint(x: 360, y: 500)
    @State private var pointB = CGPoint(x: 360, y: 300)
    @State private var pointC = CGPoint(x: 560, y: 470)

    private let starA = CGPoint(x: 160, y: 700)
    private let starB = CGPoint(x: 160, y: 300)
    private let starC = CGPoint(x: 660, y: 700)

    @State private var lengthAB: CGFloat = 0
    @State private var lengthBC: CGFloat = 0
    @State private var lengthCA: CGFloat = 0

    @State private var completedAB = false
    @State private var completedBC = false
    @State private var completedCA = false

    @State private var isShowingSuccessDialog = false

    var body: some View {
        let colorBorder:LinearGradient = LinearGradient(colors: [.planet2C1,.planet2C1, .planet2C1,], startPoint: .top, endPoint: .bottom)
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(colorBorder, lineWidth: 17)
                    .frame(width: 1080, height: 1710)
                    .shadow(color: .planet2C2, radius: 16, x: 0, y: 0)
                    .padding(.leading, -800)
                    .padding(.bottom, -2100)

                
                Image("conste1")
                    .resizable()
                    .frame(width: 240, height: 240)
                    .padding(.leading, 200)
                    .padding(.top, 409)
                Image("conste2")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .padding(.leading, -475)
                    .padding(.top, -339)
                Image("conste3")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .rotationEffect(Angle(degrees: -90))
                    .padding(.leading, -555)
                    .padding(.top, 289)
                Image("telescope")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(.trailing, 860)
                    .padding(.top, 489)
                
                Image("fullplanet02")
                    .resizable()
                    .frame(width: 1640, height: 1640)
                    .padding(.leading, -800)
                    .padding(.bottom, -1800)
                ZStack {
                        
                    
                    ZStack {
                        LuminousLineShape(pointA: pointA, pointB: starA)
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [5]))
                        LuminousLineShape(pointA: pointB, pointB: starB)
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [5]))
                        LuminousLineShape(pointA: pointC, pointB: starC)
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [5]))

                        TriangleShape(pointA: pointA, pointB: pointB, pointC: pointC)
                            .stroke(Color.white, lineWidth: 3)

                        StarView(position: starA)
                        StarView(position: starB)
                        StarView(position: starC)

                        DraggablePoint(position: $pointA, snapToPosition: starA, isCompleted: $completedAB)
                        DraggablePoint(position: $pointB, snapToPosition: starB, isCompleted: $completedAB)
                        DraggablePoint(position: $pointC, snapToPosition: starC, isCompleted: $completedCA)

                        if completedAB {
                            LengthIndicator(value: lengthAB, label: "B", isCompleted: completedAB)
                                .position(x: 100, y: 500)
                        }
                        if completedBC {
                            LengthIndicator(value: lengthBC, label: "C", isCompleted: completedBC)
                                .position(x: 490, y: 500)
                        }
                        if completedCA {
                            LengthIndicator(value: lengthCA, label: "A", isCompleted: completedCA)
                                .position(x: 400, y: 730)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .onChange(of: pointA) { _ in updateLengths() }
                    .onChange(of: pointB) { _ in updateLengths() }
                    .onChange(of: pointC) { _ in updateLengths() }
                    
                    
                    
                    if isShowingSuccessDialog {
                       // SuccessDialog(onContinue: {
                            
                        //})
                        //.padding(.top, -500)
                        //.padding(.leading, -400)


                    } else {
                        GE2DialogIG()
                            .padding(.top, -500)
                            .padding(.leading, -400)


                    }
                    
                    


                }
            }
            .padding(.leading, 200)

        }
    }

    private func distanceBetween(_ point1: CGPoint, _ point2: CGPoint) -> CGFloat {
        sqrt((point2.x - point1.x) * (point2.x - point1.x) + (point2.y - point1.y) * (point2.y - point1.y))
    }

    private func updateLengths() {
        lengthAB = distanceBetween(pointA, pointB)
        lengthBC = distanceBetween(pointB, pointC)
        lengthCA = distanceBetween(pointC, pointA)

        completedAB = pointA == starA && pointB == starB
        completedBC = pointB == starB && pointC == starC
        completedCA = pointC == starC && pointA == starA

        isShowingSuccessDialog = completedAB && completedBC && completedCA
    }
}

struct StarView: View {
    var position: CGPoint
    let size: CGFloat = 10

    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: size, height: size)
            .foregroundColor(.white)
            .position(position)
    }
}

struct LuminousLineShape: Shape {
    let pointA: CGPoint
    let pointB: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: pointA)
        path.addLine(to: pointB)
        return path
    }
}

struct TriangleShape: Shape {
    let pointA: CGPoint
    let pointB: CGPoint
    let pointC: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: pointA)
        path.addLine(to: pointB)
        path.addLine(to: pointC)
        path.addLine(to: pointA)
        return path
    }
}

#Preview {
    TelescopeEx2View()
}

