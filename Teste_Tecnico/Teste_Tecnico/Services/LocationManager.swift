//
//  LocationManager.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation
import CoreLocation
import MapKit
import Combine

//MARK: Gerenciado de Geolocalização
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    // Variáveis publicadas para a UI
    @Published var userAddress: String = "Buscando endereço..."
    @Published var userCoordinates: String = "Aguardando sinal GPS..."
    
    // Cache para evitar chamadas excessivas na API (Debounce)
    private var lastGeocodedLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    // MARK: - Delegate do CLLocationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let lat = String(format: "%.6f", location.coordinate.latitude)
        let lon = String(format: "%.6f", location.coordinate.longitude)
        let alt = String(format: "%.0fm", location.altitude)
        
        // Atualiza UI na Main Thread
        DispatchQueue.main.async {
            self.userCoordinates = "Lat: \(lat) • Lon: \(lon) • Alt: \(alt)"
        }
        
        // Busca de Endereço
        // Regra de debounce: só busca se o usuário se moveu mais de 30 metros
        if lastGeocodedLocation == nil || location.distance(from: lastGeocodedLocation!) > 30 {
            lastGeocodedLocation = location
            
            Task {
                await getAddressFrom(location: location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro GPS: \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.userAddress = "Localização indisponível"
        }
    }
    
    // MARK: - Geocodificação Reversa
    private func getAddressFrom(location: CLLocation) async {
        
        guard let request = MKReverseGeocodingRequest(location: location) else {
            DispatchQueue.main.async { self.userAddress = "Erro interno no mapa" }
            return
        }
        
        do {
            let mapItems = try await request.mapItems
            
            if let mapItem = mapItems.first,
               let fullAddress = mapItem.address?.fullAddress {
                
                DispatchQueue.main.async {
                    self.userAddress = fullAddress
                }
            } else {
                DispatchQueue.main.async {
                    self.userAddress = "Endereço não encontrado"
                }
            }
            
        } catch {
            print("Erro na geocodificação (MapKit):", error)
            DispatchQueue.main.async {
                self.userAddress = "Erro ao buscar endereço"
            }
        }
    }
}
