//
//  ReadersCoordinator.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import Foundation
import UIKit

protocol ReadersCoordinatorProtocol: CommonCoordinatorProtocol {
    func openReaderEditor()
    func popViewController()
}

final class ReadersCoordinator: BaseCoordinator {
    
    private let factory: ReadersFactoryProtocol
    private let router: Routable
    private var rootView: UINavigationController?
    
    init(factory: ReadersFactoryProtocol, router: Routable) {
        self.factory = factory
        self.router = router
    }
}

extension ReadersCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
    
    func generateViewController() -> UINavigationController {
        let readersListView = factory.makeReadersView(coordinator: self)
        self.rootView = readersListView
        return readersListView
    }
}

private extension ReadersCoordinator {
    func performFlow() {
        router.setRootModule(rootView as? Presentable)
    }
}

extension ReadersCoordinator: ReadersCoordinatorProtocol {
    func openReaderEditor() {
        let openEditorListView = factory.makeReaderEditorView(coordinator: self)
        router.push(openEditorListView as? Presentable, animated: true)
    }
    
    func popViewController() {
        router.popModule(animated: true)
    }

    
    func getNavigationController() -> UINavigationController? {
        return rootView
    }
}


