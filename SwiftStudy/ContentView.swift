import SwiftUI


import SwiftUI

class TextViewModel: ObservableObject {
    @Published var animatedText: String = ""
    private var animationTexts: [String] = []
    private var currentIndex: Int = 0
    
    func startAnimation(with texts: [String]) {
        self.animationTexts = texts
        self.currentIndex = 0
        animateText()
    }
    
    private func animateText() {
        guard currentIndex < animationTexts.count else {
            return
        }
        
        let text = animationTexts[currentIndex]
        var index = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            guard index < text.count else {
                timer.invalidate()
                self.currentIndex += 1
                self.animateText()
                return
            }
            
            let endIndex = text.index(text.startIndex, offsetBy: index + 1)
            let partialText = String(text[..<endIndex])
            self.animatedText = partialText
            index += 1
        }
    }
}


struct ContentView: View {
    @StateObject private var viewModel = TextViewModel()
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                textingMachine(text: viewModel.animatedText)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: FirstsQuestions()) {
                        Text(NSLocalizedString("I don't have a key",comment: ""))
                            .foregroundColor(.white)
                            .padding() // Добавить отступы вокруг текста кнопки
                            .background(Color.orange)
                            .cornerRadius(20)
                    }
                    
                    Button(action: {
                        self.showAlert = true
                    }) {
                        Text(NSLocalizedString("I Have a key", comment: ""))
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.orange.opacity(0.3)) // Прозрачность фона кнопки
                            )
                            
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text("This feature is under development"), dismissButton: .default(Text("OK")))
                            }
                    }
                    .padding()
                    
                    
                }
                
            }
            .navigationTitle("Registration")
            .onAppear {
                viewModel.startAnimation(with: [
                    NSLocalizedString("Hi! Here you can learn programming skills in Swift (SwiftUI).", comment: ""),
                    NSLocalizedString("Let's get started, do you already have the key of knowledge?", comment: "")
                ])
            }
        }
    }
}

#Preview{
    ContentView()
}

struct textingMachine: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
}
