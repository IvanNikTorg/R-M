//
//  DetailVC.swift
//  Rick&MortyApp
//
//  Created by user on 18.08.2023.
//

import UIKit

final class DetailVC: UIViewController {

    private let detailTableView = UITableView(frame: .zero, style: .grouped)
    private var netQuest = NetworkService()
    private var episodeProv = EpisodeProvider()


    var infoCellDataSource = InfoCell.Model(speciesTitle: "Species:", typeTitle: "Type:",
                                            genderTitle: "Gender:", species: "",
                                            type: nil, gender: "")
    var dataSourceOrigin = OriginCell.Model(namePlanet: "Earth", avatarImage: nil, bodyType: "Planet")

    var episodeDataSource: [EpisodeCell.Model] = [EpisodeCell.Model(name: "Pilot", number: "Episode:1, Season: 1",
                                                                    date: "December 2, 2013")]
    var dataUrlEpisode: [String]?
    var listSeries: [Int]?

    var avatarDataSource = AvatarCell.Model(nameCharacter: "Rick Sanchez", avatarImage: nil, rip: "Alive", id: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        //MARK: json Planet
        netQuest.getDataFromDetail(urlString: dataSourceOrigin.urlPlanet ?? "nil" , id: 1) { [weak self] resID in
            if resID?.type != nil {
                self?.dataSourceOrigin.bodyType = resID?.type ?? "None"
            }

            DispatchQueue.main.async {
                self?.detailTableView.reloadData()
            }
        }
        //MARK: json episode date


        listSeries = listIDSeries(dataUrl: dataUrlEpisode)
        if let listOfSeries = listSeries {
            episodeProv.getSeriesInNetwork(netQuest: netQuest) { [weak self] _ in
                guard let self = self else { return }
                self.episodeProv.seriesWithCharacter(id: listOfSeries)
                self.episodeDataSource = self.episodeProv.dataWithCharacter.map {
                    EpisodeCell.Model(name: $0.name, number: self.prepareEpisod(str: $0.episode), date: $0.air_date)
                }
            }
        }

    }

    func prepareEpisod(str: String) -> String {
        var seasonNum: Int
        var episodNum: Int
        guard let index = str.firstIndex(of: "E") else { return "" }
        var str2 = str[..<index]
        var str3 = str.suffix(from: index)
        str2.removeFirst()
        str3.removeFirst()
        seasonNum = Int(str2) ?? 0
        episodNum = Int(str3) ?? 0

        return "Episode: \(episodNum), Season: \(seasonNum)"
    }

    func listIDSeries(dataUrl: [String]?) -> ([Int]?) {
        guard let array = dataUrl else { return nil }
        var listSeries = [Int]()
        var temp = ""
        for el in array {
            var elTmp = el
            var ch: Character
            repeat {
                ch = elTmp.removeLast()
                if ch != "/" {
                    temp.insert(ch, at: temp.startIndex)
                }
            } while (ch != "/") && (el != "" )
            if let num = Int(temp) {
                listSeries.append(num)
                temp = ""
            }
        }
        return listSeries
    }

    func fillInfoCellDataSource(species: String?, type: String?, gender: String?) {
        if let sP = species { infoCellDataSource.species = sP }
        if let tP = type { infoCellDataSource.type = tP }
        if let gD = gender { infoCellDataSource.gender = gD }

    }

    func fillDataSourceOrigin(namePlanet: String?, avatarImage: String?, bodyType: String?, urlPlanet: String?) {
        if let nP = namePlanet { dataSourceOrigin.namePlanet = nP }
        if let aI = avatarImage { dataSourceOrigin.avatarImage = aI }
        if let bT = bodyType { dataSourceOrigin.bodyType = bT }
        if let uP = urlPlanet { dataSourceOrigin.urlPlanet = uP }

    }

    func fillEpisodeDataSource(urlArray: [String]?) {
        if let uA = urlArray { dataUrlEpisode = uA }
    }

    func fillAvatarDataSource(nameCharacter: String, avatarImage: String? ,rip: String) {
        avatarDataSource.nameCharacter = nameCharacter
        if let aI = avatarImage { avatarDataSource.avatarImage = aI }
        avatarDataSource.rip = rip

    }

    private func setupView() {

        view.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
        view.addSubview(detailTableView)
        detailTableView.allowsSelection = false
        detailTableView.separatorStyle = .none
        detailTableView.backgroundColor = .clear
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(InfoCell.self, forCellReuseIdentifier: "infoCell")
        detailTableView.register(OriginCell.self, forCellReuseIdentifier: "originCell")
        detailTableView.register(EpisodeCell.self, forCellReuseIdentifier: "episodeCell")
        detailTableView.register(AvatarCell.self, forCellReuseIdentifier: "avatarCell")
        detailTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])

    }

}

extension DetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {

        if let headerView = view as? UITableViewHeaderFooterView {

            headerView.textLabel?.textColor = .white
        }

    }
}

extension DetailVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 3) ? episodeDataSource.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let avatarCell = tableView.dequeueReusableCell(withIdentifier: "avatarCell",
                                                                 for: indexPath) as? AvatarCell
            else { return UITableViewCell() }

            avatarCell.fillCell(model: avatarDataSource)
            return avatarCell
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
            guard let episodeCell = tableView.dequeueReusableCell(withIdentifier: "episodeCell",
                                                                  for: indexPath) as? EpisodeCell
            else { return UITableViewCell() }

            episodeCell.fillCell(model: episodeDataSource[indexPath.row])
            return episodeCell
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

