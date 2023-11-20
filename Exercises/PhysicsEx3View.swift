import SwiftUI

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
}

struct QuizView: View {
    @State private var questions = [
           QuizQuestion(
               question: "¿Qué ley de Newton establece que un objeto tiende a mantener su estado de movimiento, ya sea en reposo o en movimiento constante, a menos que una fuerza neta actúe sobre él?",
               options: ["A) Primera Ley de Newton", "B) Segunda Ley de Newton", "C) Tercera Ley de Newton"],
               correctAnswer: "A) Primera Ley de Newton"
           ),
           QuizQuestion(
               question: "¿Cómo se llama la ley de Newton que establece que por cada acción hay una reacción igual y opuesta?",
               options: ["A) Primera Ley de Newton", "B) Segunda Ley de Newton", "C) Tercera Ley de Newton"],
               correctAnswer: "C) Tercera Ley de Newton"
           ),
           QuizQuestion(
               question: "¿Qué ley de Newton explica cómo la fuerza causa cambios en el movimiento de un objeto?",
               options: ["A) Primera Ley de Newton", "B) Segunda Ley de Newton", "C) Tercera Ley de Newton"],
               correctAnswer: "B) Segunda Ley de Newton"
           ),
           QuizQuestion(
               question: "¿Cuál es el nombre común de la primera ley de Newton?",
               options: ["A) Ley de la Gravitación Universal", "B) Ley de la Inercia", "C) Ley de la Atracción y Repulsión"],
               correctAnswer: "B) Ley de la Inercia"
           ),
           QuizQuestion(
               question: "¿Qué ley de Newton establece que la fuerza aplicada a un objeto es directamente proporcional a su aceleración?",
               options: ["A) Primera Ley de Newton", "B) Segunda Ley de Newton", "C) Tercera Ley de Newton"],
               correctAnswer: "B) Segunda Ley de Newton"
           ),
           QuizQuestion(
               question: "¿Qué ley de Newton afirma que las fuerzas siempre se presentan en pares, con una reacción igual y opuesta?",
               options: ["A) Primera Ley de Newton", "B) Segunda Ley de Newton", "C) Tercera Ley de Newton"],
               correctAnswer: "C) Tercera Ley de Newton"
           ),
           QuizQuestion(
               question: "¿Cuál de las leyes de Newton se relaciona directamente con la inercia de un objeto?",
               options: ["A) Primera Ley de Newton", "B) Segunda Ley de Newton", "C) Tercera Ley de Newton"],
               correctAnswer: "A) Primera Ley de Newton"
           ),
           QuizQuestion(
               question: "¿Qué ley de Newton se puede expresar como 'Fuerza igual a masa por aceleración'?",
               options: ["A) Primera Ley de Newton", "B) Segunda Ley de Newton", "C) Tercera Ley de Newton"],
               correctAnswer: "B) Segunda Ley de Newton"
           ),
           QuizQuestion(
               question: "¿Cuál de las leyes de Newton describe la relación entre la acción y la reacción?",
               options: ["A) Primera Ley de Newton", "B) Segunda Ley de Newton", "C) Tercera Ley de Newton"],
               correctAnswer: "C) Tercera Ley de Newton"
           ),
       ]
    
    
       @State private var currentQuestionIndex = 0
       @State private var userScore = 0
       @State private var showAlert = false
       @State private var timeRemaining = 10 // Tiempo en segundos
       @State private var timer: Timer? = nil
       @State private var selectedOption: String? = nil
       
       var body: some View {
           ZStack {
               BackgroundView()
                   .zIndex(0)
               
               VStack {
                   if currentQuestionIndex < questions.count {
                       RoundedRectangle(cornerRadius: 100)
                           .fill(Color.secondary)
                           .frame(width: 820, height: 290)
                           .padding()
                           .overlay(
                               VStack {
                                   Text("Pregunta \(currentQuestionIndex + 1):")
                                       .font(.system(size: 40))
                                       .foregroundColor(.white)
                                       .padding()
                                   
                                   Text(questions[currentQuestionIndex].question)
                                       .font(.system(size: 40))
                                       .foregroundColor(.white)
                                       .padding()
                                   
                               }
                           )
                           .padding()
                       
                       ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                           Button(action: {
                               checkAnswer(selectedOption: questions[currentQuestionIndex].options[index])
                           }) {
                               Text(questions[currentQuestionIndex].options[index])
                                   .font(.system(size: 40))
                                   .padding()
                                   .background(Color.secondary)
                                   .foregroundColor(.white)
                                   .cornerRadius(10)
                               
                           }
                           .padding()
                       }
                   } else {
                       Text("Resultados:")
                           .font(.largeTitle)
                           .foregroundColor(.white)
                           .padding()
                       
                       Text("Puntuación: \(userScore) / \(questions.count)")
                           .font(.largeTitle)
                           .foregroundColor(.white)
                           .padding()
                       
                       Text(getResultMessage())
                           .font(.system(size: 40)) // Aumenta el tamaño del text.system(size: 40)
                           .foregroundColor(.white)
                           .padding()
                       
                       Button(action: {
                           resetQuiz()
                       }) {
                           Text("Reiniciar Quiz")
                               .font(.title)
                               .padding() 
                               .background(Color.secondary)
                               .foregroundColor(.white)
                               .cornerRadius(10)
                       }
                       .padding()
                   }
               }
               .alert(isPresented: $showAlert) {
                   Alert(
                       title: Text("Respuesta"),
                       message: Text(getAnswerMessage()),
                       dismissButton: .default(Text("Continuar")) {
                           nextQuestion()
                       }
                   )
               }
               .onAppear {
                   startTimer()
               }
               .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                   if timeRemaining > 0 {
                       timeRemaining -= 1
                   } else {
                       // Tiempo agotado, mostrar resultados
                       showAlert = true
                   }
               }
           }
       }
       
    
       func getResultMessage() -> String {
           let percentage = Double(userScore) / Double(questions.count) * 100.0
           if percentage == 100.0 {
               return "¡Perfección! Has contestado todas las preguntas correctamente."
           } else if percentage >= 70.0 {
               return "¡Bien hecho! Has obtenido una puntuación decente."
           } else {
               return "Tienes que mejorar. Sigue practicando."
           }
       }
       
    
    func checkAnswer(selectedOption: String) {
        self.selectedOption = selectedOption // Establece la opción seleccionada
        if selectedOption == questions[currentQuestionIndex].correctAnswer {
            userScore += 1
        }
        showAlert = true
    }

    func getAnswerMessage() -> String {
        guard let selected = selectedOption else { return "" }
        if selected == questions[currentQuestionIndex].correctAnswer {
            return "Respuesta correcta: \(selected)"
        } else {
            return "Respuesta incorrecta. La respuesta correcta es: \(questions[currentQuestionIndex].correctAnswer)"
        }
    }

    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            timeRemaining = 10
            selectedOption = nil
        } else {
            // Finalizar el quiz
            currentQuestionIndex = questions.count // Esto llevará a mostrar la pantalla de resultados
            timer?.invalidate() // Detener el timer
        }
    }


    func resetQuiz() {
        currentQuestionIndex = 0
        userScore = 0
        timeRemaining = 10
        selectedOption = nil
        showAlert = false // Esto asegura que la alerta se reinicie también
    }

    
    func startTimer() {
           timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
               if timeRemaining > 0 {
                   timeRemaining -= 1
               } else {
                   showAlert = true
                   timer?.invalidate()
               }
           }
           
           // Asegúrate de agregar el temporizador al ciclo de ejecución principal
           if let timer = timer {
               RunLoop.current.add(timer, forMode: .common)
           }
       }
   }

   struct QuizView_Previews: PreviewProvider {
       static var previews: some View {
           QuizView()
       }
   }
