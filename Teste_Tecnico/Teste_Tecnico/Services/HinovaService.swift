//
//  HinovaService.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: Função de Requisição da API
class HinovaService {
    static func fetchOficinas() async throws -> [Oficina] {
        let endpoint = HinovaEndpoint.getOficinas(codigoAssociacao: 601, cpfAssociado: nil)
        
        let response = try await APIService.shared.request(endpoint: endpoint, responseModel: OficinaResponse.self)
        return response.listaOficinas
    }
    
    static func sendIndicacao(request: IndicacaoRequest) async throws -> String {
        let endpoint = HinovaEndpoint.sendIndicacao(indicacao: request)
        
        let response = try await APIService.shared.request(endpoint: endpoint, responseModel: IndicacaoResponse.self)
        
        if let mensagemSucesso = response.sucesso {
            return mensagemSucesso
        } else {
            throw APIError.unknown(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Erro desconhecido na indicação."]))
        }
    }
}

