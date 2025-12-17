//
//  ContentView.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

//MARK: Root View (View inicial)
struct RootView: View {
    @StateObject private var session = SessionManager.shared
    //Intancia o Coordinator
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        Group {
            if session.isLoggedIn {
                NavigationStack(path: $coordinator.path) {
                    HomeView()
                        .navigationDestination(for: AppRoute.self) { route in
                            coordinator.build(route: route)
                        }
                }
                .sheet(item: $coordinator.sheet) { route in
                    coordinator.build(route: route)
                }
                .environmentObject(coordinator)
                
            } else {
                LoginView()
            }
        }
        .animation(.easeInOut, value: session.isLoggedIn)
    }
}
