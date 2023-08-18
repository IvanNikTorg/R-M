//
//  EpisodCell.swift
//  Rick&MortyApp
//
//  Created by user on 18.08.2023.
//

import UIKit

final class EpisodCell: UITableViewCell {

    struct Model {
        let name: String
        let number: String
        let date: String
    }

    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
    private let dateLabel = UILabel()
    private let backView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "episodCell")
        configCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func fillCell(model: EpisodCell.Model) {
        nameLabel.text = model.name
        numberLabel.text = model.number
        dateLabel.text = model.date
    }

    private func configCell() {
        contentView.addSubview(backView)
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)

        backView.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1)
        backView.layer.cornerRadius = 16
        self.backgroundColor = .clear

        backView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            backView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])

        numberLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            numberLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -14),
            numberLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16)
        ])

        numberLabel.textColor = UIColor(red: 0.28, green: 0.77, blue: 0.04, alpha: 1)
        numberLabel.font = .systemFont(ofSize: 13, weight: .regular)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),
            nameLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16)
        ])

        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 17, weight: .medium)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -16),
            dateLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16)
        ])

        dateLabel.textColor = UIColor(red: 0.58, green: 0.6, blue: 0.61, alpha: 1)
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)


    }
}
