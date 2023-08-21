//
//  CharacterListVC.swift
//  Rick&MortyApp
//
//  Created by user on 16.08.2023.
//

import UIKit

class CharacterListVC: UIViewController {

    private var collectionView: UICollectionView?
    private lazy var titleLabel = UILabel()
    var dataSource = [CharacterCell.Model]()
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    private var netQuest = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        netQuest.getUrlList {[weak self] urlListData in
            self?.netQuest.getCharacterList(urlString: urlListData?.characters ?? "nil")
            {[weak self] resChar in
                if resChar?.results != nil, let persons = resChar?.results {
                    self?.dataSource = persons.map {
                        CharacterCell.Model(title: $0.name ?? "None", image: $0.image, id: $0.id ?? 0,
                                            episode: $0.episode, status: $0.status ?? "None",
                                            species: $0.species ?? "None", typeCreated: $0.typeCreated ?? "None",
                                            gender: $0.gender ?? "None", namePlanet: $0.origin.name ?? "None",
                                            urlLocation: $0.origin.url ?? "None")
                    }
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadData()
                    }
                }
            }
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
        
        let detailVC = DetailVC()
        detailVC.fillInfoCellDataSource(species: dataSource[indexPath.item].species,
                                        type: dataSource[indexPath.item].typeCreated,
                                        gender: dataSource[indexPath.item].gender)
        detailVC.fillDataSourceOrigin(namePlanet: dataSource[indexPath.item].namePlanet,
                                      avatarImage: nil, bodyType: dataSource[indexPath.item].urlLocation,
                                      urlPlanet: dataSource[indexPath.item].urlLocation)
        detailVC.fillAvatarDataSource(nameCharacter: dataSource[indexPath.item].title,
                                      avatarImage: dataSource[indexPath.item].image,
                                      rip: dataSource[indexPath.item].status ?? "None")
        detailVC.fillEpisodeDataSource(urlArray: dataSource[indexPath.item].episode)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
