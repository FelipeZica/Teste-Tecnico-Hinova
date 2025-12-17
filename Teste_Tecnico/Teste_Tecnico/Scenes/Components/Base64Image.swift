//
//  Base64Image.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

//MARK: Componente de Imagem retornada pela API
struct Base64Image: View {
    let base64String: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters),
                   let uiImage = UIImage(data: data) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        
                    
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .padding(geometry.size.width * 0.3)
                        .background(Color.gray.opacity(0.1))
                }
            }
        }
    }
}
