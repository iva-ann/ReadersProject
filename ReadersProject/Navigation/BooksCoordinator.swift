//
//  BooksCoordinator.swift
//  ReadersProject
//
//  Created by Анна Иванова on 26.09.2023.
//

import UIKit

protocol BooksCoordinatorProtocol: CommonCoordinatorProtocol {}

final class BooksCoordinator: BaseCoordinator {
    
    private let factory: BooksFactoryProtocol
    private let router: Routable
    private var rootView: UINavigationController?
    
    init(factory: BooksFactoryProtocol, router: Routable) {
        self.factory = factory
        self.router = router
    }
}

extension BooksCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
    func generateViewController() -> UINavigationController {
        let booksListView = factory.makeBooksView(coordinator: self)
        self.rootView = booksListView
        return booksListView
    }
}

private extension BooksCoordinator {
    func performFlow() {
        router.setRootModule(rootView as? Presentable)
    }
}

extension BooksCoordinator: BooksCoordinatorProtocol {
    func popViewController() {
        router.popModule(animated: true)
    }
    
    func getNavigationController() -> UINavigationController? {
        return rootView
    }
}

