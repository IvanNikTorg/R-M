//
//  characterCell.swift
//  Rick&MortyApp
//
//  Created by user on 18.08.2023.
//

import UIKit

final class CharacterCell: UICollectionViewCell {

    struct Model {
        let title: String
        let image: String?
        let id: Int
        let episode: [String]?
        let status: String?
        let species: String?
        let typeCreated: String?
        let gender: String?
        let namePlanet: String?
        let urlLocation: String?
    }

    private let label = UILabel()
    private let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func fillCell(model: CharacterCell.Model) {
        label.text = model.title
        guard let imageString = model.image, let url = URL(string: imageString) else { return }
        imageView.load(url: url)
    }

    private func configCell() {
        contentView.addSubview(label)
        contentView.addSubview(imageView)


        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8)
        ])

        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center

        contentView.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1)
        contentView.layer.cornerRadius = 16
    }

}
