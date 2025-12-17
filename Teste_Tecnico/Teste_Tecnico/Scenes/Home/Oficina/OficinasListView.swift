//
//  OficinasListView.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

//MARK: View da lista de Oficinas
struct OficinasListView: View {
    @StateObject private var viewModel = OficinasViewModel()
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Segmented Control
            Picker("Filtro", selection: $viewModel.selectedFilter) {
                Text("Todas").tag(0)
                Text("Ativas").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            
            // Lista de Oficinas
            if viewModel.isLoading {
                Spacer()
                ProgressView("Carregando oficinas...")
                Spacer()
            } else if let error = viewModel.errorMessage {
                Spacer()
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text(error)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Tentar Novamente") {
                        viewModel.fetchOficinas()
                    }
                }
                Spacer()
            } else {
                List(viewModel.oficinasFiltradas) { oficina in
                    Button {
                        coordinator.push(.detalhesOficina(oficina))
                    } label: {
                        OficinaRow(oficina: oficina)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .refreshable {
                    viewModel.fetchOficinas()
                }
            }
            
            
            HStack(spacing: 12) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.title2)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(locationManager.userAddress)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Text(locationManager.userCoordinates)
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.hinovaDarkBlue)
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationTitle("Oficinas")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Carrega dados apenas se a lista estiver vazia
            if viewModel.oficinas.isEmpty {
                viewModel.fetchOficinas()
            }
        }
    }
}
