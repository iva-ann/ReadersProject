//
//  BookCollectionCell.swift
//  ReadersProject
//
//  Created by Анна Иванова on 26.09.2023.
//

import UIKit

final class BookCollectionCell: UICollectionViewCell {
    
    private let bookImageView: UIImageView = UIImageView()
    private let booksNameLabel: UILabel = UILabel()
    private let booksAuthorLabel: UILabel = UILabel()
    
    private let infoStackView: UIStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with model: BookData) {
        self.booksNameLabel.text = model.name
        self.booksAuthorLabel.text = model.author
        self.bookImageView.image = model.image
    }
}

private extension BookCollectionCell {
    func setupViews() {
        self.backgroundColor = .clear
        setupImage()
        setupLabels()
        setupStackView()
    }
    
    private func setupImage() {
        bookImageView.contentMode = .scaleToFill
        bookImageView.layer.cornerRadius = 12
        bookImageView.layer.masksToBounds = true
        bookImageView.backgroundColor = .gray
        
        self.addSubview(bookImageView)
        bookImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(self.snp.height).multipliedBy(0.78)
        }
    }
    
    private func setupLabels() {
        booksNameLabel.textColor = .black
        booksNameLabel.textAlignment = .left
        booksNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        booksNameLabel.numberOfLines = 2
        booksNameLabel.setContentHuggingPriority(.required, for: .vertical)
        
        booksAuthorLabel.textColor = UIColor(hexString: "58606C")
        booksAuthorLabel.textAlignment = .left
        booksAuthorLabel.font = .systemFont(ofSize: 13, weight: .regular)
        booksAuthorLabel.numberOfLines = 2
    }
    
    private func setupStackView() {
        infoStackView.axis = .vertical
        infoStackView.alignment = .firstBaseline
        infoStackView.distribution = .fill
        
        infoStackView.addArrangedSubview(booksNameLabel)
        infoStackView.addArrangedSubview(booksAuthorLabel)
        self.addSubview(infoStackView)
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(8)
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-12)
        }
    }
}

