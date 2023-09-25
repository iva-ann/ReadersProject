//
//  ReadListModelView.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import Foundation

protocol ReadListModelViewProtocol: ReaderModuleViewModelProtocol {
    var updateViewData: ((ReadListViewData) -> ())? { get set }
    
    func viewDidLoad()
    func filterTypeDidChange(_ newType: ReaderFilteringType)
    func addReadButtonTapped()
}

final class ReadListModelView: ReadListModelViewProtocol {
    
    private var coordinator: ReadersCoordinatorProtocol?
    var updateViewData: ((ReadListViewData) -> ())?
    
    private var readers: [ReaderData]
    private var navBarData: NavBarData = {
        return NavBarData(navBarType: .default,
                          navBarTitle: "Читатели")
    }()
    
    init(coordinator: ReadersCoordinatorProtocol?) {
        self.coordinator = coordinator
        self.readers = ReaderData.mockReaders
        readers.sort(by: { $0.state.rawValue < $1.state.rawValue })
    }
    
    func viewDidLoad() {
        updateViewData?(.initial(navBarData, readers))
    }
    
    func filterTypeDidChange(_ newType: ReaderFilteringType) {
        switch newType {
        case .firstOverdue:
            readers.sort(by: { $0.state.rawValue < $1.state.rawValue })
            updateViewData?(.updateTable(newType.titleText, readers))
        case .alphabetically:
            readers.sort(by: { $0.readerName < $1.readerName })
            updateViewData?(.updateTable(newType.titleText, readers))
        }
    }
    
    func addReadButtonTapped() {
        coordinator?.openReaderEditor()
    }
}
