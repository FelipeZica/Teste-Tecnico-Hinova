//
//  LoginServiceMock.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation

//MARK: Gerenciador de login (MOCK)
class LoginServiceMock {
    
    // Simula uma chamada de API que retorna sucesso
    func login(cpf: String, senha: String, completion: @escaping (User?) -> Void) {
        
        let jsonString = """
        {
            "Id": "3555",
            "Nome": "Luiz Teste",
            "CodigoMobile": "555",
            "Cpf": "034.048.610-43",
            "Email": "luizfelipealveszica@hotmail.com",
            "Situacao": "ATIVO",
            "Telefone": "31-9999-5555"
        }
        """
        
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let user = try JSONDecoder().decode(User.self, from: jsonData)
                completion(user)
            } catch {
                print("Erro ao decodificar mock: \(error)")
                completion(nil)
            }
        }
    }
}
