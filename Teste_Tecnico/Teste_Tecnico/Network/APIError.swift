//
//  APIError.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: Casos de Erro 
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case clientError // 400-499
    case serverError // 500-599
    case decodingError(Error)
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "URL inválida."
        case .invalidResponse: return "Resposta inválida do servidor."
        case .clientError: return "Erro de requisição (Cliente)."
        case .serverError: return "Erro no servidor. Tente novamente mais tarde."
        case .decodingError(let error): return "Erro ao processar dados: \(error.localizedDescription)"
        case .unknown(let error): return "Erro desconhecido: \(error.localizedDescription)"
        }
    }
}
