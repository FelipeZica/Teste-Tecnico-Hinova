//
//  IndicacaoView.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 17/12/25.
//

import SwiftUI

//MARK: View de Indicação
struct IndicacaoView: View {
    @StateObject private var viewModel = IndicacaoViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "DADOS DO AMIGO")
                    
                    UnderlinedTextField(placeholder: "Nome do Amigo", text: $viewModel.nomeAmigo)
                        .textInputAutocapitalization(.words)
                    
                    UnderlinedTextField(
                        placeholder: "Telefone (apenas números)",
                        text: $viewModel.telefoneAmigo,
                        keyboardType: .numberPad
                    )
                    .onChange(of: viewModel.telefoneAmigo) { newValue in
                        if newValue.count > 15 {
                            viewModel.telefoneAmigo = String(newValue.prefix(15))
                        }
                        if !newValue.isEmpty {
                            viewModel.telefoneAmigo = newValue.formatPhone()
                        }
                    }
                    
                    UnderlinedTextField(placeholder: "E-mail", text: $viewModel.emailAmigo, keyboardType: .emailAddress)
                        .textInputAutocapitalization(.never)
                    if !viewModel.emailAmigo.isEmpty && !viewModel.emailAmigo.isValidEmail {
                        Text("E-mail inválido")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.leading, 4)
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "SEUS DADOS")
                    
                    UnderlinedTextField(placeholder: "Placa do seu Veículo", text: $viewModel.placaVeiculo)
                        .onChange(of: viewModel.placaVeiculo) { newValue in
                            if newValue.count > 8 {
                                viewModel.placaVeiculo = String(newValue.prefix(8)).uppercased()
                            } else {
                                viewModel.placaVeiculo = newValue.uppercased()
                            }
                        }
                    
                    UnderlinedTextField(placeholder: "Observação (Opcional)", text: $viewModel.observacao)
                }
                
                PrimaryButton(title: "Enviar Indicação", isLoading: viewModel.isLoading) {
                    hideKeyboard()
                    viewModel.sendIndicacao()
                }
                .disabled(!viewModel.isFormValid)
                .opacity(viewModel.isFormValid ? 1.0 : 0.6)
                .padding(.top, 10)
                
            }
            .padding(30)
        }
        .onTapGesture {
            hideKeyboard()
        }
        // Alertas
        .alert("Sucesso!", isPresented: $viewModel.showSuccessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.successMessage)
        }
        .alert("Ops!", isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "Erro desconhecido")
        }
    }
}

struct IndicacaoView_Previews: PreviewProvider {
    static var previews: some View {
        IndicacaoView()
    }
}
