//
//  UnderlinedTextField.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

// MARK: Componente Campo de Texto Customizado 
struct UnderlinedTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    
    @State private var showPassword: Bool = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                if isSecure && !showPassword {
                    SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray))
                        .foregroundColor(.black)
                } else {
                    TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray))
                        .foregroundColor(.black)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(.never)
                }
                
                if isSecure {
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.bottom, 4)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(.vertical, 10)
    }
}


