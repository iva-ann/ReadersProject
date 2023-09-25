//
//  ReaderTableCell.swift
//  TestProject
//
//  Created by RX Group on 23.09.2023.
//

import SnapKit

final class ReaderTableCell: UITableViewCell {
    
    private let contenBgView: UIView = UIView()
    private let nameLabel: UILabel = UILabel()
    private let dateOfBirthLabel: UILabel = UILabel()
    private let stateLabel: UILabel = UILabel()
    private let stateView: UIView = UIView()
    private let arrowImageView: UIImageView = UIImageView()
    
    private let topStackView: UIStackView = UIStackView()
    private let mainStackView: UIStackView = UIStackView()
    
    private let dateOfBirthString: String = "Дата рождения: "
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    func configure(with model: ReaderData) {
        nameLabel.text = model.readerName
        dateOfBirthLabel.text = dateOfBirthString + model.dateOfBirth
        
        stateLabel.text = model.state.titleText
        stateLabel.textColor = model.state.textColor
        stateLabel.sizeToFit()
        
        stateView.backgroundColor = model.state.bgColor
        stateView.snp.makeConstraints {
            $0.width.equalTo(stateLabel.snp.width).multipliedBy(1.4)
        }
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        contenBgView.backgroundColor = .white
        contenBgView.layer.cornerRadius = 12
        
        contenBgView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contenBgView)
        let topConst = contenBgView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomConst = contenBgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        let leadingConsrt = contenBgView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let rightConst = contenBgView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        self.addConstraints([topConst, bottomConst, leadingConsrt, rightConst])
        
        setupLabels()
        setupStateView()
        setupStackView()
    }
    
    private func setupLabels() {
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .left
        
        arrowImageView.image = UIImage(named: "rightArrow")
        arrowImageView.frame.size = CGSize(width: 15, height: 15)
        arrowImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        dateOfBirthLabel.font = .systemFont(ofSize: 14, weight: .medium)
        dateOfBirthLabel.textColor = UIColor(hexString: "717884")
        
        topStackView.axis = .vertical
        topStackView.spacing = 4
        topStackView.distribution = .equalSpacing
        topStackView.alignment = .fill
        
        topStackView.addArrangedSubview(nameLabel)
        topStackView.addArrangedSubview(dateOfBirthLabel)
    }
    
    private func setupStateView() {
        stateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        stateView.addSubview(stateLabel)
        stateView.layer.cornerRadius = 12
        stateView.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.snp.makeConstraints {
            $0.center.equalTo(stateView.snp.center)
        }
    }
    
    private func setupStackView() {
        contenBgView.addSubview(topStackView)
        topStackView.snp.makeConstraints {
            $0.top.equalTo(contenBgView.snp.top).offset(16)
            $0.leading.equalTo(contenBgView.snp.leading).offset(12)
            $0.trailing.equalTo(contenBgView.snp.trailing).offset(-35)
        }
        
        contenBgView.addSubview(stateView)
        stateView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(topStackView.snp.bottom).offset(12)
            $0.leading.equalTo(contenBgView.snp.leading).offset(12)
            $0.bottom.equalTo(contenBgView.snp.bottom).offset(-16)
        }
    }
}
