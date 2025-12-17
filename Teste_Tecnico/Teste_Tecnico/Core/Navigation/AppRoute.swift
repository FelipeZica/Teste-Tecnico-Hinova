//
//  AppRoute.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: Rotas de navegação do app
enum AppRoute: Hashable, Identifiable {
    case detalhesOficina(Oficina)
    case leitorQRCode
    case formIndicacao
    
    var id: String {
        switch self {
        case .detalhesOficina(let oficina): return "detalhe_\(oficina.id)"
        case .leitorQRCode: return "camera"
        case .formIndicacao: return "indicacao"
        }
    }
}
