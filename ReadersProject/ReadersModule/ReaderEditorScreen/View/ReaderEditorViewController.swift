//
//  ReaderEditorViewController.swift
//  ReadersProject
//
//  Created by Анна Иванова on 25.09.2023.
//

import UIKit

final class ReaderEditorViewController: UIViewController {
    
    private let navigationBar: CustomNavigationBar = CustomNavigationBar()
    private let saveButton: UIButton = UIButton()
    
    private let nameTextField: UITextField = UITextField()
    private let nameValidationLabel: UILabel = UILabel()
    private let nameStack: UIStackView = UIStackView()
    
    private let dateTextField: UITextField = UITextField()
    private let dateValidationLabel: UILabel = UILabel()
    private let dateStack: UIStackView = UIStackView()
    
    private var viewModel: ReaderEditorViewModelProtocol?
    private var isNameValid: Bool {
        guard let text = nameTextField.text else { return false }
        return text.count > 3
    }
    private var isDateValid: Bool {
        guard let text = dateTextField.text else { return false }
        return text.count > 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func backButtonTapped() {
        viewModel?.backButtonTapped()
    }
    
    @objc
    private func saveButtonTapped() {
        guard isDateValid && isNameValid else {
            showNameWarning(isNameValid)
            showDateWarning(isDateValid)
            return
        }
        guard
            let name = nameTextField.text,
            let date = dateTextField.text
        else { return }
        viewModel?.saveButtonTapped(name: name, dateOfBirth: date)
    }
    
    @objc
    private func textfFieldChanged() {
        if isNameValid {
            showNameWarning(true)
        }
        
        if isDateValid {
            showDateWarning(true)
        }
    }
}

extension ReaderEditorViewController: CommonViewProtocol {
    func setViewModel(_ viewModel: CommonViewModelProtocol) {
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
    func  initialSetup() {
        viewModel?.viewDidLoad()
        
        nameTextField.addTarget(self,
                                action: #selector(textfFieldChanged),
                                for: .editingChanged)
        dateTextField.addTarget(self,
                                action: #selector(textfFieldChanged),
                                for: .editingChanged)
        
        navigationBar.actionCompletion = { [weak self] actionType in
            switch actionType {
            case .back:   self?.backButtonTapped()
            default:      break
            }
        }
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor(hexString: "E9EDF3")
        setupNavBar()
        setupNameView()
        setupDateViwe()
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
    
    func setupNameView() {
        nameTextField.placeholder = "ФИО читателя"
        nameTextField.setAppearence()
        nameTextField.layer.borderColor = UIColor.red.cgColor
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        
        nameValidationLabel.text = "Введите ФИО читателя"
        nameValidationLabel.textAlignment = .left
        nameValidationLabel.textColor = .red
        nameValidationLabel.font = .systemFont(ofSize: 13, weight: .regular)
        nameValidationLabel.sizeToFit()
        nameValidationLabel.isHidden = true
        
        nameStack.axis = .vertical
        nameStack.spacing = 4
        nameStack.distribution = .fill
        
        nameStack.addArrangedSubview(nameTextField)
        nameStack.addArrangedSubview(nameValidationLabel)
        self.view.addSubview(nameStack)
        
        nameStack.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(16)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-16)
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
        }
    }
    
    func setupDateViwe() {
        dateTextField.placeholder = "Дата рождения"
        dateTextField.setAppearence()
        dateTextField.keyboardType = .numberPad
        dateTextField.layer.borderColor = UIColor.red.cgColor
        
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        
        dateValidationLabel.text = "Введите дату рождения читателя"
        dateValidationLabel.textAlignment = .left
        dateValidationLabel.textColor = .red
        dateValidationLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dateValidationLabel.sizeToFit()
        dateValidationLabel.isHidden = true
        
        dateStack.axis = .vertical
        dateStack.spacing = 4
        dateStack.distribution = .fill
        
        dateStack.addArrangedSubview(dateTextField)
        dateStack.addArrangedSubview(dateValidationLabel)
        self.view.addSubview(dateStack)
        
        dateStack.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(16)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-16)
            $0.top.equalTo(nameStack.snp.bottom).offset(16)
        }
        
    }
    
    func setupSaveButton() {
        saveButton.backgroundColor = UIColor(hexString: "3888FF")
        saveButton.setTitle("Cохранить", for: .normal)
        saveButton.layer.cornerRadius = 12
        
        saveButton.addTarget(self,
                             action: #selector(saveButtonTapped),
                             for: .touchUpInside)
        
        self.view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(16)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-16)
            $0.top.equalTo(dateStack.snp.bottom).offset(24)
            $0.height.equalTo(55)
        }
    }
    
    private func showNameWarning(_ isHidden: Bool) {
        nameTextField.layer.borderWidth = isHidden ? 0 : 1
        nameValidationLabel.isHidden = isHidden
    }
    
    private func showDateWarning(_ isHidden: Bool) {
        dateTextField.layer.borderWidth = isHidden ? 0 : 1
        dateValidationLabel.isHidden = isHidden
    }
}
