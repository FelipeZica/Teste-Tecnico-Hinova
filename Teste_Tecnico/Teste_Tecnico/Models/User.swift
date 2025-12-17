//
//  User.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: User Models

/// Encodificador de usuário
struct User: Codable {
    let id: String
    let nome: String
    let codigoMobile: String
    let cpf: String
    let email: String
    let situacao: String
    let telefone: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case nome = "Nome"
        case codigoMobile = "CodigoMobile"
        case cpf = "Cpf"
        case email = "Email"
        case situacao = "Situacao"
        case telefone = "Telefone"
    }
}
