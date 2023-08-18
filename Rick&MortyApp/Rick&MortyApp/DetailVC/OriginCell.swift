//
//  OriginCell.swift
//  Rick&MortyApp
//
//  Created by user on 18.08.2023.
//

import UIKit

final class OriginCell: UITableViewCell {

    struct Model {
        let namePlanet: String
        let avatarImage: UIImage?
        let bodyType: String
    }

    private let namePlanet = UILabel()
    private let avatarImage = UIImageView()
    private let bodyType = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "originCell")
        configCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func fillCell(model: OriginCell.Model) {
        namePlanet.text = model.namePlanet
        avatarImage.image = model.avatarImage
        bodyType.text = model.bodyType
    }

    private func configCell() {

        contentView.addSubview(avatarImage)
        contentView.addSubview(namePlanet)
        contentView.addSubview(bodyType)

        contentView.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1)
        contentView.layer.cornerRadius = 16
        self.backgroundColor = .clear

        avatarImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            avatarImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            avatarImage.widthAnchor.constraint(equalToConstant: 64),
            avatarImage.heightAnchor.constraint(equalToConstant: 64)
        ])

        avatarImage.layer.cornerRadius = 10
        avatarImage.backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.16, alpha: 1)

        namePlanet.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            namePlanet.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            namePlanet.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 16),
            namePlanet.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])

        namePlanet.textColor = .white
        namePlanet.font = .systemFont(ofSize: 17, weight: .medium)

        bodyType.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bodyType.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            bodyType.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 16),
            bodyType.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])

        bodyType.textColor = UIColor(red: 0.28, green: 0.77, blue: 0.04, alpha: 1)
        bodyType.font = .systemFont(ofSize: 13, weight: .regular)


    }
}

