//
//  BooksListViewController.swift
//  ReadersProject
//
//  Created by Анна Иванова on 26.09.2023.
//

import UIKit

final class BooksListViewController: UIViewController {
    
    private let navigationBar: CustomNavigationBar = CustomNavigationBar()
    private lazy var flowCollectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var  booksCollctionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowCollectionLayout)
    
    private var viewModel: BooksListModelViewProtocol?
    private var viewModelData: [BookData] = [] {
        didSet {
            self.booksCollctionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        
        navigationBar.actionCompletion = { [weak self] actionType in
            switch actionType {
            case .addEntity:   break // add action
            default:           break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
}

extension BooksListViewController: CommonViewProtocol {
    func setViewModel(_ viewModel: CommonViewModelProtocol) {
        guard let viewModel = viewModel as? BooksListModelViewProtocol else { return }
        self.viewModel = viewModel
        
        self.viewModel?.updateViewData = { [weak self] viewData in
            switch viewData {
            case .initial(let navData, let viewModelData):
                self?.navigationBar.configure(with: navData)
                self?.viewModelData = viewModelData
            }
        }
    }
}

extension BooksListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionCell", for: indexPath)
        guard let bookCell = cell as? BookCollectionCell else { return cell }
        let model = viewModelData[indexPath.row]
        bookCell.configure(with: model)
        return bookCell
    }
}

extension BooksListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        flowayout?.sectionInset.right = 0
        flowayout?.sectionInset.left = 0
        flowayout?.minimumLineSpacing = 24
        flowayout?.minimumInteritemSpacing = 16
        
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) 
        let width: CGFloat = (collectionView.frame.size.width - space) / 2.0
        let height: CGFloat = collectionView.frame.size.height * 0.42
        return CGSize(width: width, height: height)
    }
}

private extension BooksListViewController {
    func setupView() {
        self.view.backgroundColor = UIColor(hexString: "E9EDF3")
        setupNavigationBar()
        setupCollectionView()
        makeConstraints()
    }
    
    func setupNavigationBar() {
        self.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.setupDefaultNavBar(for: self.view)
    }
    
    func setupCollectionView() {
        flowCollectionLayout.scrollDirection = .vertical
        booksCollctionView.isScrollEnabled = true
        booksCollctionView.showsVerticalScrollIndicator = false
        booksCollctionView.backgroundColor = .clear
        
        booksCollctionView.dataSource = self
        booksCollctionView.delegate = self
        booksCollctionView.register(BookCollectionCell.self,  forCellWithReuseIdentifier: "BookCollectionCell")
    }
    
    func makeConstraints() {
        self.view.addSubview(booksCollctionView)
        booksCollctionView.translatesAutoresizingMaskIntoConstraints = false
        booksCollctionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        booksCollctionView.backgroundColor = .clear
        
        booksCollctionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.leading.equalTo(self.view.snp.leading).offset(16)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-16)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
    }
}
