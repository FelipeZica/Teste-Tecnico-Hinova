//
//  TabBarButton.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 17/12/25.
//

import SwiftUI

//MARK: Componente Botão da TabBar
struct TabBarButton: View {
    let icon: String
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .scaleEffect(isActive ? 1.1 : 1.0)
                
                Text(title)
                    .font(.caption2)
                    .fontWeight(isActive ? .bold : .regular)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(isActive ? .hinovaCyan : .gray.opacity(0.8))
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isActive)
        }
    }
}
