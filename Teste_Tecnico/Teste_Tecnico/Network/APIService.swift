//
//  APIService.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: Gereciador de requisições de rede
struct APIService {
    
    static let shared = APIService()
    private init() {}
    
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        
        guard let url = createURL(from: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        
        // LOG: Request
        print("[REQUEST] \(endpoint.method.rawValue) \(url.absoluteString)")
        if let body = endpoint.body, let json = String(data: body, encoding: .utf8) {
            print("[BODY]: \(json)")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            // LOG: Status Code
            print("Status Code: \(httpResponse.statusCode)")
            
            // LOG: JSON Bruto
            if let jsonString = String(data: data, encoding: .utf8) {
                print("[RESPONSE JSON]: \(jsonString)")
            }
            
            // Tratamento de resposta
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return decodedData
                } catch let decodingError as DecodingError {
                    print("[DECODE ERROR]: Falha ao mapear \(T.self)")
                    switch decodingError {
                    case .typeMismatch(let type, let context):
                        print("   Tipo incorreto: Esperava \(type), mas encontrou outro. Caminho: \(context.codingPath)")
                    case .valueNotFound(let type, let context):
                        print("   Valor nulo: O campo \(type) não pode ser nulo. Caminho: \(context.codingPath)")
                    case .keyNotFound(let key, let context):
                        print("   Chave não encontrada: '\(key.stringValue)'. Caminho: \(context.codingPath)")
                    case .dataCorrupted(let context):
                        print("   Dados corrompidos: \(context.debugDescription)")
                    @unknown default:
                        print("   Erro desconhecido: \(decodingError)")
                    }
                    throw APIError.decodingError(decodingError)
                } catch {
                    throw APIError.decodingError(error)
                }
            case 400...499:
                print("Erro Cliente")
                throw APIError.clientError
            case 500...599:
                print("Erro Servidor")
                throw APIError.serverError
            default:
                throw APIError.invalidResponse
            }
        } catch let error as APIError {
            throw error
        } catch {
            print("Erro Genérico: \(error)")
            throw APIError.unknown(error)
        }
    }
}
