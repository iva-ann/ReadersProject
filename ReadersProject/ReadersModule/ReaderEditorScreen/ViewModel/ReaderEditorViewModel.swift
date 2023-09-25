//
//  ReaderEditorViewModel.swift
//  ReadersProject
//
//  Created by Анна Иванова on 25.09.2023.
//

import Foundation

protocol ReaderEditorViewModelProtocol: CommonViewModelProtocol {
    var updateViewData: ((ReaderEditorViewData) -> ())? { get set }
    
    func viewDidLoad()
    func backButtonTapped()
    func saveButtonTapped(name: String, dateOfBirth: String)
}

final class ReaderEditorViewModel: ReaderEditorViewModelProtocol {
    
    private var coordinator: ReadersCoordinatorProtocol?
    
    var updateViewData: ((ReaderEditorViewData) -> ())?
    private var navBarData: NavBarData = {
        return NavBarData(navBarType: .large,
                          navBarTitle: "Добавить читателя")
    }()
    
    init(coordinator: ReadersCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        updateViewData?(.initial(navBarData))
    }
    
    func backButtonTapped() {
        coordinator?.popViewController()
    }
    
    func saveButtonTapped(name: String, dateOfBirth: String) {
        let newModel = ReaderData(readerName: name,
                                  dateOfBirth: dateOfBirth,
                                  state: .noBooks)
        ReaderData.mockReaders.append(newModel)
        coordinator?.popViewController()
    }
}


