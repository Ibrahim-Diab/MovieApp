//
//  AppAlert.swift
//
//  Created by Diab on 31/08/2025.
//

import UIKit

//MARK: - Private Functions to Create all type of Alerts -
fileprivate func createAlert(message: String, type: AlertType = .error) {
    TopAlert.shared.type = type
    TopAlert.shared.message = message
    TopAlert.shared.showAnimate()
}

//MARK: - App Alerts -
class AppAlert {
    
    static func showErrorAlert(error: String?){
        createAlert(message: error ?? "Error", type: .error)
    }
    static func showSuccessAlert(message: String? ){
        createAlert(message: message ?? "Success", type: .success)
    }
   
}
