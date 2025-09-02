//
//  Coordinator.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//


import UIKit

typealias CompletionBlock = (() -> Void)

protocol Coordinator:AnyObject{
    
    var onCompletion: CompletionBlock? { get set }
    var childCoordinators :[Coordinator]{ get set }
    
    func start()
    func removeDependency(_ coordinator: Coordinator?)
    func addDependency(_ coordinator: Coordinator)
    func pop()
    func dismiss()
    func popToRoot()
    
}

extension Coordinator{
    func start( ) { }
    func pop(){}
    func dismiss(){}
    func popToRoot(){}
    func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    func addDependency(_ coordinator: Coordinator) {
    for element in childCoordinators {
        if element === coordinator { return }
    }
    childCoordinators.append(coordinator)
}
}

protocol NavigationCoordinator:Coordinator{
    var navigationController: UINavigationController { get }
}


extension NavigationCoordinator{
    func pop() {
        navigationController.popViewController(animated: true)
    }
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}

public protocol Step { }

public struct DefaultStep: Step {
    public init() { }
}

