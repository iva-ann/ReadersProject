//
//  AppCoordinator.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import UIKit

class BaseCoordinator {
    
    var childCoordinators: [Coordinatable] = []
    
    func addDependency(_ coordinator: Coordinatable) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinatable?) {
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
}

// AppCoordinator
protocol CoordinatorFactoryProtocol {
    func makeReadersCoordinator(with router: Routable) -> Coordinatable & ReadersCoordinatorProtocol
}

final class AppCoordinator: BaseCoordinator {
    
    private let factory: CoordinatorFactoryProtocol
    private let router: Routable
    
    init(factory: CoordinatorFactoryProtocol, router: Routable) {
        self.factory = factory
        self.router = router
    }
}

// MARK:- Coordinatable
extension AppCoordinator: Coordinatable {
    func start() {
        //        TO DO: realization for generation tabbar
        performReadersFlow()
        
    }
    
    // MARK:- Private methods
    func performReadersFlow() {
        let coordinator = factory.makeReadersCoordinator(with: router)
        addDependency(coordinator)
        coordinator.start()
    }
}
