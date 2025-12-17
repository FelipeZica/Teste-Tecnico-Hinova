//
//  AppCoordinator.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI
import Combine

class AppCoordinator: ObservableObject {
    // A pilha de navegação
    @Published var path = NavigationPath()
    @Published var sheet: AppRoute?
    
    // MARK: - Ações de Navegação
    
    // Ir para uma tela
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    // Voltar uma tela
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    // Voltar para a raiz (Home)
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    // Abrir modal
    func present(_ route: AppRoute) {
        self.sheet = route
    }
    
    // Fecha modal
    func dismissSheet() {
        self.sheet = nil
    }
    
    // MARK: - View Builder (Criação das telas)
    @ViewBuilder
    func build(route: AppRoute) -> some View {
        switch route {
        case .detalhesOficina(let oficina):
            OficinaDetailView(oficina: oficina)
            
        case .leitorQRCode:
            ImagePicker(onImagePicked: { image in
                print("imagem capturada")
            }, sourceType: .camera)
            
        case .formIndicacao:
            Text("Formulário")
        }
    }
}
