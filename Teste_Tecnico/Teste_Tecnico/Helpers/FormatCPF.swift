//
//  formatCPF.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: Máscara de CPF
extension String {
    /// Aplica a máscara de CPF (XXX.XXX.XXX-XX)
    func formatCPF() -> String {
        let clean = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "###.###.###-##"
        
        var result = ""
        var index = clean.startIndex
        
        for ch in mask where index < clean.endIndex {
            if ch == "#" {
                result.append(clean[index])
                index = clean.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
}
