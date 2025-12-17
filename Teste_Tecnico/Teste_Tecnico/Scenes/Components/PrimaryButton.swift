//
//  PrimaryButton.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

// MARK: Componente Botão Primário
struct PrimaryButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.hinovaDarkBlue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .disabled(isLoading)
        .opacity(isLoading ? 0.7 : 1.0)
    }
}
