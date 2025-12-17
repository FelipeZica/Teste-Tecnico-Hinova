//
//  LocationManager.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 16/12/25.
//

import Foundation
import CoreLocation
import Combine
import Contacts

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // MARK: - Properties
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var lastGeocodedLocation: CLLocation?
    
    @Published var userAddress: String = "Buscando endereço..."
    @Published var userCoordinates: String = "Aguardando sinal GPS..."
    
    // MARK: - Initialization
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        updateCoordinates(location)
        
        // Debounce: Atualiza a distancia se o usuario se mover mais de 30 metros
        if lastGeocodedLocation == nil || location.distance(from: lastGeocodedLocation!) > 30 {
            lastGeocodedLocation = location
            Task {
                await resolveAddress(for: location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.userAddress = "Localização indisponível"
        }
    }
    
    // MARK: - Private Methods
    
    /// Formata as cordenadas para UI
    private func updateCoordinates(_ location: CLLocation) {
        let lat = String(format: "%.6f", location.coordinate.latitude)
        let lon = String(format: "%.6f", location.coordinate.longitude)
        let alt = String(format: "%.0fm", location.altitude)
        
        DispatchQueue.main.async {
            self.userCoordinates = "Lat: \(lat) • Lon: \(lon) • Alt: \(alt)"
        }
    }
    
    /// Busca o endereço, funções para o IOS 26 e versões anteriores
    private func resolveAddress(for location: CLLocation) async {
        if #available(iOS 9999, *) {

        } else {
            do {
                try await geocodeLegacy(location: location)
            } catch {
                DispatchQueue.main.async {
                    self.userAddress = "Endereço não encontrado"
                }
            }
        }
    }
    
    /// Geolocalização legado (IOS 18 ou inferior)
    private func geocodeLegacy(location: CLLocation) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let self = self, let placemark = placemarks?.first else {
                    continuation.resume(throwing: NSError(domain: "LocationManager", code: 404))
                    return
                }
                
                let formattedAddress = self.formatPlacemark(placemark)
                
                DispatchQueue.main.async {
                    self.userAddress = formattedAddress
                }
                continuation.resume()
            }
        }
    }
    
    /// Formata o CLPlacemark
    private func formatPlacemark(_ placemark: CLPlacemark) -> String {
        if let postalAddress = placemark.postalAddress {
            let formatter = CNPostalAddressFormatter()
            formatter.style = .mailingAddress
            return formatter.string(from: postalAddress).replacingOccurrences(of: "\n", with: " - ")
        }
        
        let street = placemark.thoroughfare ?? ""
        let number = placemark.subThoroughfare ?? ""
        let city = placemark.locality ?? ""
        
        return [street, number, city].filter { !$0.isEmpty }.joined(separator: ", ")
    }
}
