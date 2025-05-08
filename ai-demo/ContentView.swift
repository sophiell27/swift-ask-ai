//
//  ContentView2.swift
//  ai-demo
//
//  Created by Sophie Lam on 6/5/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputText: String = ""
    @State private var responseText: String = ""
    @State private var isLoading: Bool  = false
    
    let aiService = AIService()
    
    var body: some View {
        VStack {
            TextField("Please enter your prompt: ", text: $inputText).padding().border(Color.gray)
            
            AsyncButton {
                isLoading = true
                responseText = await aiService.getAIResponse(prompt: inputText)
                isLoading = false
            } label: {
                Text("Ask AI").padding().foregroundColor(isLoading ? .gray : .mint).cornerRadius(20)
            }
        }.padding()
        
        VStack {
            ProgressView().opacity(isLoading ? 1: 0)
            ScrollView {
                Text(responseText).opacity(isLoading ? 0.5: 1)
            }
        }
    }
}

#Preview {
    ContentView()
}
