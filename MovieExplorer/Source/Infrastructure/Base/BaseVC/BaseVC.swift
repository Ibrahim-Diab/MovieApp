//
//  BaseVC.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//

import UIKit


class BaseVC:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    }
    
    func showIndicator() {
        AppIndicator.shared.show(isGif: true)
    }
    func hideIndicator() {
        AppIndicator.shared.dismiss()
    }
    
    func show(successMessage message: String) {
        AppAlert.showSuccessAlert(message: message)
    }
    func show(errorMessage message: String) {
        AppAlert.showErrorAlert(error: message)
    }

    deinit {
        print("\(self.className) is deinit, No memory leak found")
    }
    
    
}
