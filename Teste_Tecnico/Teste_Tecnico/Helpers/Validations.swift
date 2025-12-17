//
//  Validations.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: Validações de dados
extension String {
    
    /// Remove formatação (pontos e traços), deixando apenas números
    var numbersOnly: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    /// Valida se a senha tem pelo menos 8 caracteres
    var isValidPassword: Bool {
        return self.count >= 8
    }
    
    /// Valida se o CPF é verdadeiro usando o algoritmo oficial
    var isValidCPF: Bool {
        let cpf = self.numbersOnly
        
        guard cpf.count == 11, Set(cpf).count != 1 else { return false }
        
        let numbers = cpf.compactMap({ Int(String($0)) })
        guard numbers.count == 11 else { return false }
        
        func calculateDigit(slice: ArraySlice<Int>) -> Int {
            var sum = 0
            var multiplier = slice.count + 1
            
            for number in slice {
                sum += number * multiplier
                multiplier -= 1
            }
            
            let remainder = sum % 11
            return remainder < 2 ? 0 : 11 - remainder
        }
        
        let digit1 = calculateDigit(slice: numbers[0..<9])
        let digit2 = calculateDigit(slice: numbers[0..<10])
        
        return digit1 == numbers[9] && digit2 == numbers[10]
    }
    
    /// Valida se o e-mail está no formato correto
    var isValidEmail: Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: self)
        }
}
