//
//  Indicacao.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: Indicação Models

/// Decodificador de resposta
struct IndicacaoResponse: Decodable {
    let sucesso: String?
            let erroObjeto: RetornoErroWrapper?
            
            enum CodingKeys: String, CodingKey {
                case sucesso = "Sucesso"
                case erroObjeto = "RetornoErro"
            }
            
            struct RetornoErroWrapper: Decodable {
                let retornoErro: String?
            }
}

/// Encodificador de requisição
struct IndicacaoRequest: Codable {
    let indicacao: IndicacaoData
    let remetente: String
    let copias: [String]
    
    enum CodingKeys: String, CodingKey {
        case indicacao = "Indicacao"
        case remetente = "Remetente"
        case copias = "Copias"
    }
}

/// Encodificador do body da requisição
struct IndicacaoData: Codable {
    let codigoAssociacao: String
    let dataCriacao: String
    let cpfAssociado: String
    let emailAssociado: String
    let nomeAssociado: String
    let telefoneAssociado: String
    let placaVeiculoAssociado: String
    let nomeAmigo: String
    let telefoneAmigo: String
    let emailAmigo: String
    let observacao: String?
    
    enum CodingKeys: String, CodingKey {
        case codigoAssociacao = "CodigoAssociacao"
        case dataCriacao = "DataCriacao"
        case cpfAssociado = "CpfAssociado"
        case emailAssociado = "EmailAssociado"
        case nomeAssociado = "NomeAssociado"
        case telefoneAssociado = "TelefoneAssociado"
        case placaVeiculoAssociado = "PlacaveiculoAssociado" 
        case nomeAmigo = "NomeAmigo"
        case telefoneAmigo = "TelefoneAmigo"
        case emailAmigo = "EmailAmigo"
        case observacao = "Observacao"
    }
}
