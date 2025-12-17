//
//  InfoRow.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

//MARK: Componente de informação da view de detalhes
struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(.hinovaCyan)
                .frame(width: 24, height: 24)
            
            Text(text)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .frame(alignment: .leading)
        }
        .padding(.vertical, 2)
    }
}
