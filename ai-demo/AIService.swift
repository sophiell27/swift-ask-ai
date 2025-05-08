//
//  AIService.swift
//  ai-demo
//
//  Created by Sophie Lam on 6/5/2025.
//

import Foundation

class AIService {
    private let networkManager = NetworkManager()
    private let requestBuilder = RequestBuilder(apiKey: ProcessInfo.processInfo.environment["API_KEY"] ?? "")
    private let errorMessage = "Error: unable to generate AI response"
    
    private let url = URL(string: ProcessInfo.processInfo.environment["CHAT_URL"] ?? "")
    
    func getAIResponse (prompt: String) async -> String {
        guard let request = requestBuilder.buildRequest(prompt: prompt, url:url) else {
            print("no url")
            return errorMessage
        }
        
        do {
            let data = try await networkManager.sendRequest(request)
            return decodeResponse(data)
        }catch {
            print("Error: sending request. detail: \(error.localizedDescription)")
            return errorMessage
        }
    }
    
    private func decodeResponse(_ data: Data) -> String {
        do {
            let apiResponses = try JSONDecoder().decode([AIResponse].self, from: data)
            return  apiResponses.first?.generated_text ?? "No response found"
            
        }catch {
            print("Error: fail to decode repsonse \(error.localizedDescription)")
            return errorMessage
        }
    }
    
}
