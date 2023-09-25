//
//  ReaderEditorViewController.swift
//  ReadersProject
//
//  Created by Анна Иванова on 25.09.2023.
//

import UIKit

final class ReaderEditorViewController: UIViewController {
    
    private let navigationBar: NavigationBar = NavigationBar()
    private let nameTextField: UITextField = UITextField()
    private let dateTextField: UITextField = UITextField()
    private let saveButton: UIButton = UIButton()
    
    private var viewModel: ReaderEditorViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        
        navigationBar.actionCompletion = { [weak self] actionType in
            switch actionType {
            case .back:   self?.backButtonTapped()
            default:      break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func backButtonTapped() {
        viewModel?.backButtonTapped()
    }
}

extension ReaderEditorViewController: ReaderModuleViewProtocol {
    func setViewModel(_ viewModel: ReaderModuleViewModelProtocol) {
        guard let viewModel = viewModel as? ReaderEditorViewModelProtocol else { return }
        self.viewModel = viewModel
        self.viewModel?.updateViewData = { [weak self] viewData in
            switch viewData {
            case .initial(let navBarData):
                self?.navigationBar.configure(with: navBarData)
            }
        }
    }
}

private extension ReaderEditorViewController {
    func setupView() {
        self.view.backgroundColor = UIColor(hexString: "E9EDF3")
        setupNavBar()
        setupTextFields()
        setupSaveButton()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top)
            $0.width.equalTo(self.view.snp.width)
            $0.centerX.equalTo(self.view.snp.centerX)
            $0.height.equalTo(160)
        }
    }
    
    func setupTextFields() {
        nameTextField.placeholder = "ФИО читателя"
        nameTextField.setAppearence()
        
        self.view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(16)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-16)
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.height.equalTo(55)
        }
        
        dateTextField.placeholder = "Дата рождения"
        dateTextField.setAppearence()
        
        self.view.addSubview(dateTextField)
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(16)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-16)
            $0.top.equalTo(nameTextField.snp.bottom).offset(16)
            $0.height.equalTo(55)
        }
    }
    
    func setupSaveButton() {
        saveButton.backgroundColor = UIColor(hexString: "3888FF")
        saveButton.setTitle("Cохранить", for: .normal)
        saveButton.layer.cornerRadius = 12
        
        self.view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(16)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-16)
            $0.top.equalTo(dateTextField.snp.bottom).offset(24)
            $0.height.equalTo(55)
        }
    }
}
