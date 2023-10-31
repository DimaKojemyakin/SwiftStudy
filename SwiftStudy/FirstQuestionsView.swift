// FirstQuestionsView.swift

import SwiftUI

struct FirstsQuestions: View {
    @StateObject private var viewModel = TextViewModel()
    @State private var username: String = ""
    @State private var selectedOption = 0
    @State private var isPickerEnglishVisible = false
    @State private var isPickerSwiftVisible = false
    @State var indexPecker = 0
    var dataTwo: [String] = [
        NSLocalizedString("beginner", comment: ""),
        NSLocalizedString("intermediate", comment: ""),
        NSLocalizedString("experienced", comment: ""),
        NSLocalizedString("Professional", comment: "")
    ]
    
    var data: [String] = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
    
    var body: some View {
        VStack {
            textingMachine(text: viewModel.animatedText)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
            TextField("Username", text: $username)
                
                .padding()
            
            if isPickerEnglishVisible {
                Picker(selection: $selectedOption, label: Text("Select Option")) {
                    ForEach(0..<data.count) { index in
                        Text(self.data[index]).tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
            }
            if isPickerSwiftVisible {
                Picker(selection: $selectedOption, label: Text("Select Option")) {
                    ForEach(0..<dataTwo.count) { index in
                        Text(self.dataTwo[index]).tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
            }
            
            Button(action: {
                if indexPecker <= 0 {
                    self.isPickerEnglishVisible.toggle()
                    self.isPickerSwiftVisible.toggle()
                    indexPecker += 1
                    print(indexPecker)
                } else {
                    return
                }
            }) {
                Text("Toggle Picker")
            }
            
            .padding()
            .onAppear {
                viewModel.startAnimation(with: [
                    NSLocalizedString("Hi, my name is Gaga. Very nice to meet you! What's your name", comment: "")
                ])
            }
        }
    }
}

struct FirstsQuestions_Previews: PreviewProvider {
    static var previews: some View {
        FirstsQuestions()
    }
}
