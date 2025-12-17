//
//  CreateURL.swift
//  Teste_Tecnico
//
//  Created by Luiz Felipe on 17/12/25.
//

import Foundation

//MARK: Helper para montar a URL com Query Params
extension APIService{
    internal func createURL(from endpoint: Endpoint) -> URL? {
        var components = URLComponents(string: endpoint.baseURL + endpoint.path)
        components?.queryItems = endpoint.queryItems
        return components?.url
    }
}
