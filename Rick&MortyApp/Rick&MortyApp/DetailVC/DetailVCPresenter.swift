//
//  DetailVCPresenter.swift
//  Rick&MortyApp
//
//  Created by user on 22.08.2023.
//

import UIKit

protocol DetailVCPresenterProtocol: AnyObject {
    func getData()
}

final class DetailVCPresenter: DetailVCPresenterProtocol {

    weak var output: DetailVCPresenterOutput?
    private let character: CharacterCell.Model
    private let episodeProv = EpisodeProvider()

    init(character: CharacterCell.Model) {
        self.character = character
    }

    func getData() {
        output?.updateAvatarSection(with: getAvatarCellModel())
        output?.updateInfoSection(with: getInfoCellModel())
        getOriginCellModel { [weak self] model in
            self?.output?.updateOriginSection(with: model)
        }
        getEpisodeCellModel { [weak self] models in
            self?.output?.updateEpisodesSection(with: models)
        }
    }

    private func getAvatarCellModel() -> AvatarCell.Model {
        return AvatarCell.Model(nameCharacter: character.title, avatarImage: character.image,
                                rip: character.status ?? "None")
    }

    private func getInfoCellModel() -> InfoCell.Model {
        return InfoCell.Model(speciesTitle: "Species:", typeTitle: "Type:",
                              genderTitle: "Gender", species: character.species ?? "None",
                              type: character.typeCreated ?? "None", gender: character.gender ?? "None")
    }

    private func getOriginCellModel(completion: @escaping (OriginCell.Model) -> ()) {
        NetworkService.shared.getDataFromDetail(urlString: character.urlLocation ?? "") { resID in
            completion(OriginCell.Model(namePlanet: resID?.namePlanet ?? "None", bodyType: resID?.type ?? "None"))
        }
    }

    private func getEpisodeCellModel(completion: @escaping ([EpisodeCell.Model]) -> ()) {
        let listSeries = listIDSeries(dataUrl: character.episode)
        if let listOfSeries = listSeries {
            episodeProv.getSeriesInNetwork() { [weak self] _ in
                guard let self = self else { return }
                self.episodeProv.seriesWithCharacter(id: listOfSeries)
                let models = self.episodeProv.dataWithCharacter.map {
                    EpisodeCell.Model(name: $0.name, number: self.prepareEpisod(str: $0.episode), date: $0.air_date)
                }
                completion(models)
            }
        }
    }

   private func prepareEpisod(str: String) -> String {
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

   private func listIDSeries(dataUrl: [String]?) -> ([Int]?) {
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

}
