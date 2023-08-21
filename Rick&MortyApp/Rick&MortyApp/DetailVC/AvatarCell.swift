//
//  AvatarCell.swift
//  Rick&MortyApp
//
//  Created by user on 18.08.2023.
//

import UIKit

final class AvatarCell: UITableViewCell {

    struct Model {
        var nameCharacter: String
        var avatarImage: String?
        var rip: String
        var id: Int
    }

    private let nameLable = UILabel()
    private let avatarImage = UIImageView()
    private let ripLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "avatarCell")
        configCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func fillCell(model: AvatarCell.Model) {
        nameLable.text = model.nameCharacter
        ripLabel.text = model.rip
        guard let imageString = model.avatarImage, let url = URL(string: imageString) else { return }
        avatarImage.load(url: url)
    }

    private func configCell() {

        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLable)
        contentView.addSubview(ripLabel)
        self.backgroundColor = .clear

        avatarImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 148),
            avatarImage.heightAnchor.constraint(equalToConstant: 148)
        ])

        avatarImage.layer.cornerRadius = 16
        avatarImage.clipsToBounds = true
        avatarImage.backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.16, alpha: 1)

        nameLable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLable.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 24),
            nameLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        nameLable.textColor = .white
        nameLable.font = .systemFont(ofSize: 22, weight: .bold)   //to do check font

        ripLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ripLabel.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 8),
            ripLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ripLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        ripLabel.textColor = UIColor(red: 0.28, green: 0.77, blue: 0.04, alpha: 1)
        ripLabel.font = .systemFont(ofSize: 16, weight: .regular)     //to do check font


    }
}





