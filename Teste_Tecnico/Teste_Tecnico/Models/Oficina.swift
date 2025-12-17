//
//  OficinaResponse.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: Oficina Models

/// Decodificador de resposta
struct OficinaResponse: Codable {
    let listaOficinas: [Oficina]
    
    enum CodingKeys: String, CodingKey {
        case listaOficinas = "ListaOficinas"
    }
}

/// Decodificador do objeto Oficina
struct Oficina: Codable, Identifiable,Hashable{
    let id: Int
    let nome: String
    let descricao: String
    let descricaoCurta: String
    let endereco: String
    let latitude: String
    let longitude: String
    let foto: String 
    let avaliacaoUsuario: Int
    let email: String?
    let telefone1: String?
    let telefone2: String?
    let ativo: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case nome = "Nome"
        case descricao = "Descricao"
        case descricaoCurta = "DescricaoCurta"
        case endereco = "Endereco"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case foto = "Foto"
        case avaliacaoUsuario = "AvaliacaoUsuario"
        case email = "Email"
        case telefone1 = "Telefonel"
        case telefone2 = "Telefone2"
        case ativo = "Ativo"
    }
}
