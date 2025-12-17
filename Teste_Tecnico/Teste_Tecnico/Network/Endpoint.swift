//
//   Tipos de método HTTP.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//MARK: Endpoints da API (Montador de requisições)
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

enum HinovaEndpoint: Endpoint {
    case getOficinas(codigoAssociacao: Int, cpfAssociado: String?)
    case sendIndicacao(indicacao: IndicacaoRequest)
    
    var baseURL: String {
        return "https://dev.hinovamobile.com.br/ProvaConhecimentoWebApi"
    }
    
    var path: String {
        switch self {
        case .getOficinas:
            return "/api/Oficina"
        case .sendIndicacao:
            return "/api/Indicacao"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getOficinas: return .get
        case .sendIndicacao: return .post
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getOficinas:
            return ["Content-Type": "application/json"]
        case .sendIndicacao:
            return ["Content-Type": "application/json"]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getOficinas(let codigo, let cpf):
            var items = [URLQueryItem(name: "codigoAssociacao", value: String(codigo))]
            if let cpf = cpf {
                items.append(URLQueryItem(name: "cpfAssociado", value: cpf))
            }
            return items
        case .sendIndicacao:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .getOficinas:
            return nil
        case .sendIndicacao(let requestModel):
            return try? JSONEncoder().encode(requestModel)
        }
    }
}
