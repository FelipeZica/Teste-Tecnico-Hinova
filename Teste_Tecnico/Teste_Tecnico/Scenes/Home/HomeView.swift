//
//  HomeView.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import SwiftUI

//MARK: Home
struct HomeView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            TabView(selection: $selectedTab) {
                OficinasListView()
                    .tag(0)
                
                IndicacaoView()
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.3), value: selectedTab)
            
            HStack(spacing: 0) {
                TabBarButton(
                    icon: "wrench.and.screwdriver.fill",
                    title: "Oficinas",
                    isActive: selectedTab == 0
                ) {
                    withAnimation(.easeInOut) {
                        selectedTab = 0
                    }
                }
                
                TabBarButton(
                    icon: "person.badge.plus",
                    title: "Indicação",
                    isActive: selectedTab == 1
                ) {
                    withAnimation(.easeInOut) {
                        selectedTab = 1
                    }
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 30)
            .background(Color.white)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: -5)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle(selectedTab == 0 ? "Oficinas" : "Convide amigos")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
