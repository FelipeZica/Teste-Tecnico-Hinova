//
//  OficinasViewModel.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation
import Combine

@MainActor
class OficinasViewModel: ObservableObject {
    
    @Published var oficinas: [Oficina] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var selectedFilter: Int = 0
    
    //Filtra as oficinas pelo status
    var oficinasFiltradas: [Oficina] {
        if selectedFilter == 1 {
            return oficinas.filter { $0.ativo }
        }
        return oficinas
    }
    
    //Requisição de busca das oficinas
    func fetchOficinas() {
        self.isLoading = true
        self.errorMessage = nil
        
        //Inicia a requisição
        Task {
            do {
                let endpoint = HinovaEndpoint.getOficinas(codigoAssociacao: 601, cpfAssociado: nil)
                
                let response = try await APIService.shared.request(endpoint: endpoint, responseModel: OficinaResponse.self)
                
                self.oficinas = response.listaOficinas
                self.isLoading = false
            } catch {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
                print("Erro ao buscar oficinas: \(error)")
            }
        }
    }
}
