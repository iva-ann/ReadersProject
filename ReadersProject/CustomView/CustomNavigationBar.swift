//
//  NavigationBar.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import UIKit

struct NavBarData {
    let navBarType: NavigationBarType
    let navBarTitle: String
}

enum  NavigationBarType {
    case `default`
    case large
}

enum NavBarActionType {
    case addEntity
    case back
}

final class CustomNavigationBar: UIView {
    
    private let title: UILabel = UILabel()
    private let actionButton: UIButton = UIButton()
    
    var actionCompletion: ((NavBarActionType) -> Void)?
    
    enum Constants {
        static let horizontalSpacing: CGFloat = 16
        static let bottomSpacing: CGFloat = 10
    }
    
    func configure(with data: NavBarData) {
        self.backgroundColor = UIColor(hexString: "F8F8F9")
        setupTitle(data.navBarTitle)
        
        switch data.navBarType {
        case .default:      setupAddButton()
        case .large:        setupBackButton()
        }
    }
    
    private func setupTitle(_ text: String) {
        title.text = text
        title.font = .boldSystemFont(ofSize: 28)
        title.textColor = .black
        title.sizeToFit()
        
        
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).offset(-Constants.bottomSpacing)
            $0.leading.equalTo(self.snp.leading).offset(Constants.horizontalSpacing)
        }
    }
    
    private func setupAddButton() {
        let image = UIImage(named: "addIcon")
        actionButton.setImage(image, for: .normal)
        actionButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        
        actionButton.setTitle("Добавить", for: .normal)
        actionButton.setTitleColor(UIColor(hexString: "3888FF"), for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 15)
        
        actionButton.addTarget(self,
                               action: #selector(addButtonTapped),
                               for: .touchUpInside)
        
        
        addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).offset(-Constants.bottomSpacing)
            $0.trailing.equalTo(self.snp.trailing).offset(-Constants.horizontalSpacing)
        }
    }
    
    private func setupBackButton() {
        let image = UIImage(named: "leftArrow")
        actionButton.setImage(image, for: .normal)
        
        actionButton.addTarget(self,
                               action: #selector(backButtonTapped),
                               for: .touchUpInside)
        
        self.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.snp.makeConstraints {
            $0.bottom.equalTo(title.snp.top).offset(-Constants.bottomSpacing)
            $0.leading.equalTo(self.snp.leading).offset(Constants.horizontalSpacing)
        }
    }
    
    @objc
    private func addButtonTapped() {
        actionCompletion?(.addEntity)
    }
    
    @objc
    private func backButtonTapped() {
        actionCompletion?(.back)
    }
}

extension CustomNavigationBar {
    func setupDefaultNavBar(for superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.snp.makeConstraints {
            $0.height.equalTo(110)
            $0.width.equalTo(superView.snp.width)
            $0.top.equalTo(superView.snp.top)
            $0.centerX.equalTo(superView.snp.centerX)
        }
    }
}
