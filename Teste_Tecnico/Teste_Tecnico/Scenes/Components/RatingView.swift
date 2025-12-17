//
//  RatingView.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 17/12/25.
//

import SwiftUI

//MARK: Componente Avaliação de Oficina
struct RatingView: View {
    let rating: Int
    var maxRating: Int = 5
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(index <= rating ? .yellow : .gray.opacity(0.3))
                    .font(.caption) // Tamanho discreto, ideal para ficar abaixo da foto
            }
        }
    }
}
