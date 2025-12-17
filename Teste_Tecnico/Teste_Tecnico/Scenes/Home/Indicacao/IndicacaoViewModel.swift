//
//  IndicacaoViewModel.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 17/12/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class IndicacaoViewModel: ObservableObject {
    
    // MARK: - Dados do Amigo (Inputs)
    @Published var nomeAmigo = ""
    @Published var telefoneAmigo = ""
    @Published var emailAmigo = ""
    
    // MARK: - Dados do Associado (Automáticos + Placa)
    @Published var placaVeiculo = ""
    @Published var observacao = ""
    
    // Estados da Tela
    @Published var isLoading = false
    @Published var showSuccessAlert = false
    @Published var errorMessage: String?
    @Published var successMessage = ""
    
    private let user: User?
    
    init() {
        // Carrega dados do usuário logado
        self.user = SessionManager.shared.currentUser
    }
    
    // Valida os campos
    var isFormValid: Bool {
        return !nomeAmigo.isEmpty &&
        !telefoneAmigo.isEmpty &&
        !placaVeiculo.isEmpty &&
        emailAmigo.isValidEmail
    }
    
    // Requisição de enviar indicação
    func sendIndicacao() {
        guard let user = user else {
            self.errorMessage = "Erro: Usuário não identificado."
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        // Formata a Data Atual (yyyy-MM-dd)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.string(from: Date())
        
        //Remove os caractéres especiais
        let telefoneAmigoClean = self.telefoneAmigo.numbersOnly
        let placaClean = self.placaVeiculo.replacingOccurrences(of: "-", with: "")
        
        // Monta o Objeto
        let dadosIndicacao = IndicacaoData(
            codigoAssociacao: "601",
            dataCriacao: todayDate,
            cpfAssociado: user.cpf,
            emailAssociado: user.email,
            nomeAssociado: user.nome,
            telefoneAssociado: user.telefone,
            placaVeiculoAssociado: placaClean,
            nomeAmigo: self.nomeAmigo,
            telefoneAmigo: telefoneAmigoClean,
            emailAmigo: self.emailAmigo,
            observacao: self.observacao
        )
        
        // Monta a request
        let request = IndicacaoRequest(
            indicacao: dadosIndicacao,
            remetente: user.email,
            copias: []
        )
        
        // Inicia a requisição
        Task {
            do {
                let mensagem = try await HinovaService.sendIndicacao(request: request)
                self.successMessage = mensagem
                self.showSuccessAlert = true
                self.clearFilds()
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    // Limpa os textfields
    private func clearFilds() {
        nomeAmigo = ""
        telefoneAmigo = ""
        emailAmigo = ""
        placaVeiculo = ""
        observacao = ""
    }
}
