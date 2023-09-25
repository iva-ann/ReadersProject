//
//  AppCoordinator.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import UIKit

class BaseCoordinator {
    
    var childCoordinators: [Coordinatable] = []
    
    func addDependency(_ coordinator: Coordinatable?) {
        guard let coordinator = coordinator else { return }
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

final class AppCoordinator: BaseCoordinator {
    
    private let factory: CoordinatorFactoryProtocol
    private let tabBarController: UITabBarController
    private var router: Routable
    
    private var readersCoordinator: CommonCoordinatorProtocol?
    private var booksCoordinator: CommonCoordinatorProtocol?
    
    init(factory: CoordinatorFactoryProtocol, tabBarController: UITabBarController) {
        self.factory = factory
        self.tabBarController = tabBarController
        self.router = Router()
    }
    
    private func generateTabBar() {
        setupTabBar()
        readersCoordinator = factory.makeReadersCoordinator(with: router)
        booksCoordinator = factory.makeBooksCoordinator(with: router)
        addDependency(readersCoordinator)
        addDependency(booksCoordinator)
        
        guard
        let readersView = readersCoordinator?.generateViewController(),
        let booksView = booksCoordinator?.generateViewController()
        else { return }
        
        readersView.tabBarItem = UITabBarItem(title: "Читатели",
                                             image: UIImage(named: "readersIcon"),
                                             tag: 0)
        booksView.tabBarItem = UITabBarItem(title: "Книги",
                                             image: UIImage(named: "booksIcon"),
                                             tag: 1)
        tabBarController.viewControllers = [readersView, booksView]
    }
    
    private func setupTabBar() {
        tabBarController.tabBar.backgroundColor = UIColor(hexString: "F8F8F9")
        tabBarController.tabBar.selectedImageTintColor = UIColor(hexString: "3888FF")
        tabBarController.tabBar.unselectedItemTintColor = UIColor(hexString: "717884")
    }
}

// MARK:- Coordinatable
extension AppCoordinator: Coordinatable {
    func start() {
        generateTabBar()
        performReadersFlow()
    }
    
    // MARK:- Private methods
    func performReadersFlow() {
        let readersView = readersCoordinator?.getNavigationController()
        router.setNavigationController(readersView)
        readersCoordinator?.start()
    }
}
