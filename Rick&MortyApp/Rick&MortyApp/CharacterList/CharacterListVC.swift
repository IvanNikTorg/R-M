//
//  CharacterListVC.swift
//  Rick&MortyApp
//
//  Created by user on 16.08.2023.
//

import UIKit

protocol CharacterListPresenterOutput: UIViewController {
    func updateTableView(with data: [CharacterCell.Model])
}

class CharacterListVC: UIViewController {

    var presenter: CharacterListPresenterProtocol?

    private var collectionView: UICollectionView?
    private lazy var titleLabel = UILabel()
    private var activityView: UIActivityIndicatorView?

    private var dataSource = [CharacterCell.Model]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showActivityIndicator()
        presenter?.getData()
    }

    private func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        guard let activityView = activityView else { return }
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }

    private func hideActivityIndicator() {
        if (activityView != nil) {
            activityView?.stopAnimating()
            activityView = nil
        }
    }

    private func setupView() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)

        view.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.attributedText = NSMutableAttributedString(string: "Characters", attributes: [NSAttributedString.Key.kern: 0.36])

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24)
        ])

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: 156, height: 202)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        guard let collectionView = collectionView else {return}
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "characterCell")

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 31),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension CharacterListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let charCell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell",
                                                                for: indexPath) as? CharacterCell
        else { return UICollectionViewCell() }
        charCell.fillCell(model: dataSource[indexPath.row])
        return charCell
    }
}

extension CharacterListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCell(at: indexPath.item)
    }
}

extension CharacterListVC: CharacterListPresenterOutput {
    func updateTableView(with data: [CharacterCell.Model]) {
        dataSource = data
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            self.collectionView?.reloadData()
        }
    }
}
