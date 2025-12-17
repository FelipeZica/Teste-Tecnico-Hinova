//
//  OficinaRow.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

//MARK: Célula da table de Oficinas
struct OficinaRow: View {
    let oficina: Oficina
    
    var body: some View {
        HStack {
            Base64Image(base64String: oficina.foto)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(oficina.nome)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(oficina.descricaoCurta)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                if oficina.ativo {
                    Text("Ativo")
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .cornerRadius(4)
                } else {
                    Text("Inativo")
                        .font(.caption2)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
