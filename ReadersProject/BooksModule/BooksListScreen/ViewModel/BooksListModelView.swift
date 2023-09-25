//
//  BooksListModelView.swift
//  ReadersProject
//
//  Created by Анна Иванова on 26.09.2023.
//

import Foundation

protocol BooksListModelViewProtocol: CommonViewModelProtocol {
    var updateViewData: ((BooksListViewData) -> ())? { get set }
    
    func viewDidLoad()
}

final class BooksListModelView: BooksListModelViewProtocol {
    
    private var coordinator: BooksCoordinatorProtocol?
    var updateViewData: ((BooksListViewData) -> ())?
    
    private var books: [BookData]
    private var navBarData: NavBarData = {
        return NavBarData(navBarType: .default,
                          navBarTitle: "Книги")
    }()
    
    init(coordinator: BooksCoordinatorProtocol?) {
        self.coordinator = coordinator
        books = BookData.mockData
    }
    
    func viewDidLoad() {
        self.updateViewData?(.initial(navBarData, books))
    }
    
    
}
