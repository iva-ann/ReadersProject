//
//  ReadersListViewController.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import UIKit

final class ReadersListViewController: UIViewController {
    
    private let navigationBar: CustomNavigationBar = CustomNavigationBar()
    private let filterButton: UIButton = UIButton()
    private let tableView: UITableView = UITableView()
    
    private var viewModel: ReadListModelViewProtocol?
    private var viewModelData: [ReaderData] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        
        navigationBar.actionCompletion = { [weak self] actionType in
            switch actionType {
            case .addEntity:   self?.addReaderButtonTapped()
            default:           break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewDidLoad()
        setupView()
    }
    
    private func overdueBooksFilteringTapped() {
        viewModel?.filterTypeDidChange(.firstOverdue)
    }
    
    private func alphabeticalFilteringTapped() {
        viewModel?.filterTypeDidChange(.alphabetically)
    }
    
    private func addReaderButtonTapped() {
        viewModel?.addReadButtonTapped()
    }
}


extension ReadersListViewController: CommonViewProtocol {
    func setViewModel(_ viewModel: CommonViewModelProtocol) {
        guard let viewModel = viewModel as? ReadListModelViewProtocol else { return }
        self.viewModel = viewModel
        
        self.viewModel?.updateViewData = { [weak self] viewData in
            switch viewData {
            case .initial(let navData, let viewModelData):
                self?.navigationBar.configure(with: navData)
                self?.viewModelData = viewModelData
            case .updateTable(let buttonTitle, let viewModelData):
                self?.filterButton.setTitle(buttonTitle, for: .normal)
                self?.filterButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -7)
                self?.viewModelData = viewModelData
            }
        }
    }
}

extension ReadersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReaderTableCell", for: indexPath)
        guard let readerCell = cell as? ReaderTableCell else { return cell }
        let model = viewModelData[indexPath.row]
        readerCell.configure(with: model)
        return readerCell
    }
}


private extension ReadersListViewController {
    func setupView() {
        self.view.backgroundColor = UIColor(hexString: "E9EDF3")
        setupNavigationBar()
        setupFilterButton()
        setupTableView()
    }
    
    func setupNavigationBar() {
        self.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.setupDefaultNavBar(for: self.view)
    }
    
    private func setupFilterButton() {
        let image = UIImage(named: "arrow")
        filterButton.setImage(image, for: .normal)
        filterButton.semanticContentAttribute = .forceRightToLeft
        filterButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -7)
        
        filterButton.setTitle("Сначала просроченные книги", for: .normal)
        filterButton.setTitleColor(UIColor(hexString: "3888FF"), for: .normal)
        
        self.view.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        let topConstr = filterButton.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 16)
        let leftConstr = filterButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8)
        self.view.addConstraints([topConstr, leftConstr])
        
        let overdueBooksFiltering = UIAction(title: "Сначала просроченные книги") { [weak self] _ in
            self?.overdueBooksFilteringTapped()
        }
        let alphabeticalFiltering = UIAction(title: "По алфавиту") { [weak self] _ in
            self?.alphabeticalFilteringTapped()
        }
        
        let menu = UIMenu(children: [overdueBooksFiltering, alphabeticalFiltering])
        filterButton.menu = menu
        filterButton.showsMenuAsPrimaryAction = true
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(ReaderTableCell.self, forCellReuseIdentifier: "ReaderTableCell")
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConst = tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 16)
        let leftConst = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8)
        let rightConst = tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8)
        let bottomConst = tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10)
        self.view.addConstraints([topConst, leftConst, rightConst, bottomConst])
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
}
