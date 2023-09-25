//
//  Factory.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import Foundation

final class CoordinatorFactory {
    private let moduleFactory: ModuleFactory = ModuleFactory()
    
}

extension CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeReadersCoordinator(with router: Routable) -> Coordinatable & ReadersCoordinatorProtocol {
        return ReadersCoordinator(factory: moduleFactory, router: router)
    }
}

protocol ReadersFactoryProtocol {
    func makeReadersView(coordinator: ReadersCoordinatorProtocol) -> ReaderModuleViewProtocol
    func makeReaderEditorView(coordinator: ReadersCoordinatorProtocol) -> ReaderModuleViewProtocol
}

final class ModuleFactory {}

extension ModuleFactory: ReadersFactoryProtocol {
    func makeReadersView(coordinator: ReadersCoordinatorProtocol) -> ReaderModuleViewProtocol {
        let view: ReaderModuleViewProtocol = ReadersListViewController()
        let viewModel: ReadListModelViewProtocol = ReadListModelView(coordinator: coordinator)
        view.setViewModel(viewModel)
        return view
    }
    
    func makeReaderEditorView(coordinator: ReadersCoordinatorProtocol) -> ReaderModuleViewProtocol {
        let view: ReaderModuleViewProtocol = ReaderEditorViewController()
        let viewModel: ReaderEditorViewModelProtocol = ReaderEditorViewModel(coordinator: coordinator)
        view.setViewModel(viewModel)
        return view
    }
}


