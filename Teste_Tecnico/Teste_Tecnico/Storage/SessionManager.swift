//
//  SessionManager.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation
import SwiftUI
import Combine

//MARK: Armazenamento Local
class SessionManager: ObservableObject {
    
    // Singleton
    static let shared = SessionManager()
    
    @Published var currentUser: User?
    
    private let userDefaults = UserDefaults.standard
    private let userKey = "user_session_key"
    
    private init() {
        loadUser()
    }
    
    // MARK: - Computed Property para verificar se está logado
    var isLoggedIn: Bool {
        return currentUser != nil
    }
    
    // MARK: - Save
    func login(user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            userDefaults.set(data, forKey: userKey)
            
            self.currentUser = user
            print("Usuário salvo e logado com sucesso.")
        } catch {
            print("Erro ao salvar usuário: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Load
    func loadUser() {
        guard let data = userDefaults.data(forKey: userKey) else { return }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            self.currentUser = user
        } catch {
            print("Erro ao decodificar usuário salvo: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Delete (Logout)
    func logout() {
        userDefaults.removeObject(forKey: userKey)
        self.currentUser = nil
    }
}
