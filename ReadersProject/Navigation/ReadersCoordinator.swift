//
//  ReadersCoordinator.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import Foundation

protocol ReadersCoordinatorProtocol {
    func  openReaderEditor()
    func popViewController()
}

protocol ReaderModuleViewProtocol {
    func setViewModel(_ viewModel: ReaderModuleViewModelProtocol)
}

protocol ReaderModuleViewModelProtocol {}

final class ReadersCoordinator: BaseCoordinator {
    
    private let factory: ReadersFactoryProtocol
    private let router: Routable
    
    init(factory: ReadersFactoryProtocol, router: Routable) {
        self.factory = factory
        self.router = router
    }
}

extension ReadersCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

private extension ReadersCoordinator {
    func performFlow() {
        let readersListView = factory.makeReadersView(coordinator: self)
        router.setRootModule(readersListView as? Presentable)
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
}


