//
//  NetworkConfig.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import Foundation

public enum NetworkConfig {
    static var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "API_Key") as? String ?? ""
    }
    
    static var baseUrl: String {
        Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? ""
    }
}
