//
//  SectionHeader.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 17/12/25.
//

import SwiftUI

//MARK: Componente Header da Table de Oficinas
struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .padding(.top, 10)
    }
}
