//
//  NetworkLogger.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//


import Foundation
import Alamofire

enum NetworkLogger {
    
    // MARK: - Request (from Endpoint)
    static func log<E: Endpoint>(request endpoint: E) {
        #if DEBUG
        print( "🛰 [REQUEST] =============================")
        print(" ➡️ URL::\(endpoint.url)")
        print("---------------------------------")
        print(" ➡️ METHOD::\(endpoint.method.rawValue)")
        print("---------------------------------")
        if let headers = endpoint.headers, !headers.isEmpty {
            print(" ➡️ HEADERS::\n\(headers)")
        }
        print("---------------------------------")
        if let params = endpoint.parameters, !params.isEmpty {
            print(" ➡️ PARAMETERS::\(params)")
        }
        print(" [End REQUEST] =========================================\n")
        #endif
    }
    
    // MARK: - Response (from AFDataResponse)
    static func log<Value>(response: AFDataResponse<Value>) {
        #if DEBUG
        print(" 📡 [RESPONSE] ===========================")
        
        if let httpResponse = response.response {
            print(" ⬅️ URL::\(httpResponse.url?.absoluteString ?? "")")
            print("---------------------------------")
            print(" ⬅️ STATUS CODE::\(httpResponse.statusCode)")
            print("---------------------------------")
            print(" ⬅️ HEADERS::\n\(httpResponse.headers)")
            print("---------------------------------")
        }
        
        if let data = response.data, !data.isEmpty {
            print(" ⬅️ BODY::")
            print(prettyJSONString(from: data) ?? String(data: data, encoding: .utf8) ?? "⚠️ Cannot decode response body")
        }
        print(" [End RESPONSE] =========================================")
        #endif
    }
    
    // MARK: - Error
    static func log(error: Error) {
        #if DEBUG
        print("\n❌ [ERROR] ===============================")
        print("\n\(error.localizedDescription)\n")
        print("=========================================\n")
        #endif
    }
    
    // MARK: - JSON Helper
    private static func prettyJSONString(from data: Data) -> String? {
        guard
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let prettyData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyString = String(data: prettyData, encoding: .utf8)
        else {
            return nil
        }
        return prettyString
    }
}
