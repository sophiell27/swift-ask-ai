//
//  NetworkManager.swift
//  ai-demo
//
//  Created by Sophie Lam on 6/5/2025.
//

import Foundation

class NetworkManager {
    func sendRequest (_ request : URLRequest) async throws -> Data {
        let (responseData, _) = try await URLSession.shared.data(for: request)
        
        return responseData
    }
}
