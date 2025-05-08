//
//  RequestBuilder.swift
//  ai-demo
//
//  Created by Sophie Lam on 6/5/2025.
//

import Foundation

class RequestBuilder {
    private var apiKey: String = ""
    
    init (apiKey: String) {
        self.apiKey = apiKey
    }
    
    func buildRequest(prompt: String, url: URL?) -> URLRequest? {
        guard let apiUrl = url else {
            return nil
        }
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "inputs":prompt
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            return nil
        }
        request.httpBody = jsonData
        return request
        
        
    }
}
