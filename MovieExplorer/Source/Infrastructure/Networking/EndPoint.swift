//
//  EndPoint.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import Foundation
import Alamofire

public protocol Endpoint {
    associatedtype Response: Decodable
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}


public struct ConfigEndpoint<Response: Decodable>: Endpoint {
    
    public let baseURL: String = NetworkConfig.baseUrl
    public let path: String
    public let method: HTTPMethod
    public let headers: HTTPHeaders? = [
        "Content-Type": "application/json",
        "Authorization": "Bearer \(NetworkConfig.apiKey)"
    ]
    public let parameters: Parameters?
    public let encoding: ParameterEncoding
    
    
    init(path: String,
         method: HTTPMethod,
         parameters: Parameters? = nil,
         encoding: ParameterEncoding = URLEncoding.default) {
        
        self.path = path
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
    }
}

public extension Endpoint {
    var url: String {
        return baseURL + path
    }
}


