//
//  CommonProtocols.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import UIKit

protocol Coordinatable: AnyObject {
    func start()
    func generateViewController() -> UINavigationController
}

extension Coordinatable {
    func generateViewController() -> UINavigationController { return UINavigationController() }
}

protocol CommonViewProtocol {
    func setViewModel(_ viewModel: CommonViewModelProtocol)
}

protocol CommonViewModelProtocol {}

protocol CommonCoordinatorProtocol: Coordinatable {
    func getNavigationController() -> UINavigationController?
}

protocol Routable: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: CompletionBlock?)
    
    func setNavigationController(_ controller: UINavigationController?)
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}


protocol Presentable {
    var toPresent: UIViewController? { get }
}

extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}
