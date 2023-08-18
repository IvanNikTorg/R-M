//
//  DetailVC.swift
//  Rick&MortyApp
//
//  Created by user on 18.08.2023.
//

import UIKit

final class DetailVC: UIViewController {

    private let detailTableView = UITableView()

    var infoCellDataSource = InfoCell.Model(speciesTitle: "Species:", typeTitle: "Type:",
                                                               genderTitle: "Gender:", species: "Human",
                                                               type: nil, gender: "Male")
    var dataSourceOrigin = OriginCell.Model(namePlanet: "Earth", avatarImage: nil, bodyType: "Planet")

    var episodDataSource: [EpisodCell.Model] = [EpisodCell.Model(name: "Pilot", number: "Episode:1, Season: 1",
                                                                 date: "December 2, 2013"),
                                                EpisodCell.Model(name: "Pilot", number: "Episode:1, Season: 1",
                                                                 date: "December 2, 2013"),
                                                EpisodCell.Model(name: "Pilot", number: "Episode:1, Season: 1",
                                                                 date: "December 2, 2013")]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    private func setupView() {

        view.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
        view.addSubview(detailTableView)
        
        detailTableView.backgroundColor = .clear
        detailTableView.dataSource = self
        detailTableView.register(InfoCell.self, forCellReuseIdentifier: "infoCell")
        detailTableView.register(OriginCell.self, forCellReuseIdentifier: "originCell")
        detailTableView.register(EpisodCell.self, forCellReuseIdentifier: "episodCell")

        detailTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            detailTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            detailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])

    }


}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 3) ? episodDataSource.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell",
                                                               for: indexPath) as? InfoCell
            else { return UITableViewCell() }

            infoCell.fillCell(model: infoCellDataSource)
            return infoCell
        case 2:
            guard let originCell = tableView.dequeueReusableCell(withIdentifier: "originCell",
                                                                 for: indexPath) as? OriginCell
            else { return UITableViewCell() }

            originCell.fillCell(model: dataSourceOrigin)
            return originCell
        case 3:
            guard let episodCell = tableView.dequeueReusableCell(withIdentifier: "episodCell",
                                                                 for: indexPath) as? EpisodCell
            else { return UITableViewCell() }

            episodCell.fillCell(model: episodDataSource[indexPath.row])
            return episodCell
        default:
            return UITableViewCell()
        }



    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Info"
        case 2:
            return "Origin"
        case 3:
            return "Episodes"
        default:
            return nil
        }
    }

    
}

