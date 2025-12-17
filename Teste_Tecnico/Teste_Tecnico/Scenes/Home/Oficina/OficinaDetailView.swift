//
//  OficinaDetailView.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

//MARK: View de detalhes da Oficina
struct OficinaDetailView: View {
    let oficina: Oficina
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                Base64Image(base64String: oficina.foto)
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Avaliação:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        RatingView(rating: oficina.avaliacaoUsuario)
                    }
                    .padding(.top, 8)
                    
                    Text(oficina.nome)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if !oficina.descricaoCurta.isEmpty {
                        Text(oficina.descricaoCurta)
                            .font(.headline)
                            .foregroundColor(.hinovaCyan)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Divider()
                    
                    Text(oficina.descricaoFormatted)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    InfoRow(icon: "map.fill", text: oficina.endereco)
                    
                    if let tel = oficina.telefone1, !tel.isEmpty {
                        InfoRow(icon: "phone.fill", text: tel)
                    }
                    
                    if let email = oficina.email, !email.isEmpty {
                        InfoRow(icon: "envelope.fill", text: email)
                    }
                }
                .padding()
                
                //MARK: Botão para abrir a câmera
                Button(action: {
                    coordinator.present(.leitorQRCode)
                }) {
                    Label("Leitor de QRCode", systemImage: "qrcode.viewfinder")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.hinovaDarkBlue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(oficina.nome)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OficinaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let oficinaMock = Oficina(id: 1, nome: "Oficina do Tio Zé com um Nome Muito Grande Ltda", descricao: "Esta é uma descrição muito longa para testar se o texto vai quebrar a linha corretamente na tela de detalhes ou se vai ficar cortado com três pontinhos feios.", descricaoCurta: "Desc Curta", endereco: "Rua das Flores, 1234 - Bairro Industrial Longe Demais - Cidade Teste - MG", latitude: "", longitude: "", foto: "", avaliacaoUsuario: 5, email: "email.muito.longo.para.teste@oficinagigante.com.br", telefone1: "31 99999-9999", telefone2: nil, ativo: true)
        
        NavigationView {
            OficinaDetailView(oficina: oficinaMock)
        }
    }
}
