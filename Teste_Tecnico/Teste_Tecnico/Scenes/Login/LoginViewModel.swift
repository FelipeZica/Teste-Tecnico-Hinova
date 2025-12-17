//
//  LoginViewModel.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    
    // MARK: - Propriedades da UI
    @Published var cpf = ""
    @Published var senha = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    private let loginService = LoginServiceMock()
    
    // MARK: - Lógica de Validação
    
    var isFormValid: Bool {
        return !cpf.isEmpty && !senha.isEmpty
    }
    
    //Requisição de login
    func performLogin() {
        self.errorMessage = nil
        self.isLoading = true
        
        // Valida CPF
        if !cpf.isValidCPF {
            self.errorMessage = "Por favor, insira um CPF válido."
            self.isLoading = false
            return
        }
        
        // Valida Senha
        if !senha.isValidPassword {
            self.errorMessage = "A senha deve conter pelo menos 8 caracteres."
            self.isLoading = false
            return
        }
        
        //Simula a requisição de login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            self.loginService.login(cpf: self.cpf.numbersOnly, senha: self.senha) { user in
                self.isLoading = false
                
                if let user = user {
                    SessionManager.shared.login(user: user)
                } else {
                    self.errorMessage = "Usuário ou senha inválidos."
                }
            }
        }
    }
}
