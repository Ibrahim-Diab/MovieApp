//
//  NetworkExecutor.swift
//  MovieExplorer
//
//  Created by Diab on 1/09/2025.
//

import Foundation
import Combine
import Alamofire

public protocol NetworkExecutor {
    func execute<E: Endpoint>(_ endpoint: E) -> AnyPublisher<E.Response, NetworkError>
}

public final class DefaultNetworkExecutor: NetworkExecutor {
    
    public init() {}
    
    public func execute<E: Endpoint>(_ endpoint: E) -> AnyPublisher<E.Response, NetworkError> {
        
        NetworkLogger.log(request: endpoint)
        
        return Future<E.Response, NetworkError> { promise in
            AF.request(
                endpoint.url,
                method: endpoint.method,
                parameters: endpoint.parameters,
                encoding: endpoint.encoding,
                headers: endpoint.headers
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: E.Response.self, decoder: JSONDecoder()) { response in
                
                switch response.result {
                case .success(let value):
                    NetworkLogger.log(response: response)
                    promise(.success(value))
                case .failure(let afError):
                    if let decodingError = afError.underlyingError as? DecodingError {
                        NetworkLogger.log(error: decodingError)
                        promise(.failure(.decodingError(decodingError)))
                    } else if let statusCode = response.response?.statusCode {
                        NetworkLogger.log(error: afError)
                        promise(.failure(.serverError(statusCode)))
                    } else {
                        NetworkLogger.log(error: afError)
                        promise(.failure(.unknown(afError)))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

