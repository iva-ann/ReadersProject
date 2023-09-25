//
//  Factory.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import Foundation
import UIKit

protocol CoordinatorFactoryProtocol {
    func makeReadersCoordinator(with router: Routable) -> CommonCoordinatorProtocol
    func makeBooksCoordinator(with router: Routable) -> CommonCoordinatorProtocol
}

final class CoordinatorFactory {
    private let moduleFactory: ModuleFactory = ModuleFactory()
    
}

extension CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeReadersCoordinator(with router: Routable) -> CommonCoordinatorProtocol {
        return ReadersCoordinator(factory: moduleFactory, router: router)
    }
    
    func makeBooksCoordinator(with router: Routable) -> CommonCoordinatorProtocol {
        return BooksCoordinator(factory: moduleFactory, router: router)
    }
}

protocol ReadersFactoryProtocol {
    func makeReadersView(coordinator: ReadersCoordinatorProtocol) -> UINavigationController
    func makeReaderEditorView(coordinator: ReadersCoordinatorProtocol) -> CommonViewProtocol
}

protocol BooksFactoryProtocol {
    func makeBooksView(coordinator: BooksCoordinatorProtocol) -> UINavigationController
}


final class ModuleFactory {}

extension ModuleFactory: ReadersFactoryProtocol {
    func makeReadersView(coordinator: ReadersCoordinatorProtocol) -> UINavigationController {
        let view = ReadersListViewController()
        let viewModel: ReadListModelViewProtocol = ReadListModelView(coordinator: coordinator)
        view.setViewModel(viewModel)
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    func makeReaderEditorView(coordinator: ReadersCoordinatorProtocol) -> CommonViewProtocol {
        let view = ReaderEditorViewController()
        let viewModel: ReaderEditorViewModelProtocol = ReaderEditorViewModel(coordinator: coordinator)
        view.setViewModel(viewModel)
        return view
    }
}

extension ModuleFactory: BooksFactoryProtocol {
    func makeBooksView(coordinator: BooksCoordinatorProtocol) -> UINavigationController {
        let view = BooksListViewController()
        let viewModel: BooksListModelViewProtocol = BooksListModelView(coordinator: coordinator)
        view.setViewModel(viewModel)
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}


