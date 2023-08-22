//
//  DetailVC.swift
//  Rick&MortyApp
//
//  Created by user on 18.08.2023.
//

import UIKit

protocol DetailVCPresenterOutput: AnyObject {
    func updateAvatarSection(with model: AvatarCell.Model)
    func updateInfoSection(with model: InfoCell.Model)
    func updateOriginSection(with model: OriginCell.Model)
    func updateEpisodesSection(with model: [EpisodeCell.Model])
}

final class DetailVC: UIViewController {

    var presenter: DetailVCPresenter?

    private let detailTableView = UITableView(frame: .zero, style: .grouped)

    var avatarDataSource: AvatarCell.Model?
    var infoDataSource: InfoCell.Model?
    var originDataSource: OriginCell.Model?
    var episodeDataSource = [EpisodeCell.Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getData()
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
            headerView.textLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
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

            infoCell.fillCell(model: infoDataSource)
            return infoCell
        case 2:
            guard let originCell = tableView.dequeueReusableCell(withIdentifier: "originCell",
                                                                 for: indexPath) as? OriginCell
            else { return UITableViewCell() }

            originCell.fillCell(model: originDataSource)
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

extension DetailVC: DetailVCPresenterOutput {
    func updateAvatarSection(with model: AvatarCell.Model) {
        avatarDataSource = model
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }

    func updateInfoSection(with model: InfoCell.Model) {
        infoDataSource = model
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }

    func updateOriginSection(with model: OriginCell.Model) {
        originDataSource = model
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }

    func updateEpisodesSection(with model: [EpisodeCell.Model]) {
        episodeDataSource = model
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }


}
