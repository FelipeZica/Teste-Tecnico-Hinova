//
//  LoginView.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

//MARK: View Login
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    // MARK: - Formulário
                    VStack(spacing: 25) {
                        UnderlinedTextField(
                            placeholder: "CPF (apenas números)",
                            text: $viewModel.cpf,
                            keyboardType: .numberPad
                        )
                        .onChange(of: viewModel.cpf) { newValue in
                            if newValue.count > 14 {
                                viewModel.cpf = String(newValue.prefix(14))
                            }
                            let formatted = newValue.formatCPF()
                            if newValue != formatted {
                                viewModel.cpf = formatted
                            }
                        }
                        
                        
                        UnderlinedTextField(
                            placeholder: "Senha",
                            text: $viewModel.senha,
                            isSecure: true
                        )
                        
                        PrimaryButton(
                            title: "Entrar",
                            isLoading: viewModel.isLoading
                        ) {
                            hideKeyboard()
                            viewModel.performLogin()
                        }
                        .padding(.top, 30)
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
            .alert("Atenção", isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "Ocorreu um erro desconhecido.")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
