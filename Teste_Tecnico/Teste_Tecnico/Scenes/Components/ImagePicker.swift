//
//  ImagePicker.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 17/12/25.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    // Função para definir o que fazer com a imagem
    var onImagePicked: (UIImage) -> Void
    
    // Bindings para fechar a tela
    @Environment(\.presentationMode) var presentationMode
    
    // Tipo: .camera ou .photoLibrary
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        // Verifica se a fonte está disponível
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            picker.sourceType = sourceType
        } else {
            picker.sourceType = .photoLibrary
        }
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // O Coordinator que escuta os eventos da câmera
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImagePicked(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
