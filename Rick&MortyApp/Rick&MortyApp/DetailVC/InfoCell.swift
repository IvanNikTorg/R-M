//
//  InfoCell.swift
//  Rick&MortyApp
//
//  Created by user on 18.08.2023.
//

import UIKit

final class InfoCell: UITableViewCell {

    struct Model {
        let speciesTitle: String
        let typeTitle: String
        let genderTitle: String

        let species: String
        let type: String?
        let gender: String
    }

    private let speciesRow = InfoRow()
    private let typeRow = InfoRow()
    private let genderRow = InfoRow()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "infoCell")
        configCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func fillCell(model: InfoCell.Model) {
        speciesRow.fill(title: model.speciesTitle, value: model.species)
        typeRow.fill(title: model.typeTitle, value: model.type)
        genderRow.fill(title: model.genderTitle, value: model.gender)
    }

    private func configCell() {

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.addArrangedSubview(speciesRow)
        stack.addArrangedSubview(typeRow)
        stack.addArrangedSubview(genderRow)

        contentView.addSubview(stack)
        contentView.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1)
        contentView.layer.cornerRadius = 16
        self.backgroundColor = .clear

        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }

}

private class InfoRow: UIView {

    private let title = UILabel()
    private let value = UILabel()

    func fill(title: String, value: String?) {
        self.title.text = title
        self.value.text = value ?? "None"
    }

    init(){
        super.init(frame: .zero)
        config()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func config() {
        title.textColor = UIColor(red: 0.77, green: 0.79, blue: 0.89, alpha: 1)
        title.font = .systemFont(ofSize: 16, weight: .regular)
        title.textAlignment = .left
        value.textColor = .white
        value.font = .systemFont(ofSize: 16, weight: .regular)
        value.textAlignment = .right

        self.addSubview(title)
        self.addSubview(value)

        title.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])

        value.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            value.topAnchor.constraint(equalTo: self.topAnchor),
            value.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            value.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])

    }
}
