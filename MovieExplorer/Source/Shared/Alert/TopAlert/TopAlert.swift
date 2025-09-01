//
//  TopAlert.swift
//
//  Created by Diab on 31/08/2025.
//


import UIKit

//MARK: - Enums
enum AlertType: Equatable {
    
    case success
    case error
      
    var image: String {
        switch self {
        case .success:
            return SFSymbol.success.rawValue
        case .error:
            return SFSymbol.error.rawValue
        }
    }
    
    var color: UIColor {
        switch self {
        case .success:
            return .white
        case .error:
            return .white
        }
    }
    
    var indicatorColor: UIColor {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        }
    }
}

class TopAlert {
    
    //MARK: - Properties -
    private var isLongPressActive: Bool = false
    private var isSwipePerformed: Bool = false
    private let view = AlertView(frame: .zero)
    var message: String = "Error"
    var type: AlertType = .error
    
    //MARK: - Initialization -
    static let shared: TopAlert = TopAlert()
    private init() {}
    
    //MARK: - Animation -
    func showAnimate(){
        
        let window = UIApplication.shared.keyWindow
        guard let window = window else {
            return
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(view)
        view.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        view.set(message: message, type: type)
        view.showAnimate()
    }
}
