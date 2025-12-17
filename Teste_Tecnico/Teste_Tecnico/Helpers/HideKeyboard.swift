//
//  hideKeyboard.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 17/12/25.
//

import SwiftUI

//MARK: Função auxiliar para esconder o teclado
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
