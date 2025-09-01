//
//  AppDIContainer.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//


import UIKit

public class AppDIContainer {
 
    
    private lazy var apiDataTransferService: NetworkExecutor = {
        return DefaultNetworkExecutor()
    }()
    

    // MARK: - Home Module -
    
    func buildHomeModule() -> HomeDIContainer {
        let dependencies = HomeDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return HomeDIContainer(dependencies: dependencies)
    }
    
 
}

