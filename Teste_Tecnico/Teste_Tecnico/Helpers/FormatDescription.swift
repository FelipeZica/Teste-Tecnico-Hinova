//
//  FormatDescription.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 17/12/25.
//

import Foundation

//MARK: Substitui a quebra de texto //n para \n
extension Oficina {
    var descricaoFormatted: String {
        return descricao
            .replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "/n", with: "\n")
    }
}
