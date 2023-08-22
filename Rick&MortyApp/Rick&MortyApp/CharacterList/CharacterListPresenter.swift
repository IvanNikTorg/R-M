//
//  CharacterListPresenter.swift
//  Rick&MortyApp
//
//  Created by user on 18.08.2023.
//

import UIKit

protocol CharacterListPresenterProtocol: AnyObject {
    func getData()
    func didSelectCell(at index: Int)
}

final class CharacterListPresenter: CharacterListPresenterProtocol {

    weak var output: CharacterListPresenterOutput?

    private var dataSource = [CharacterCell.Model]()

    func getData() {
        NetworkService.shared.getCharacterList { [weak self] resChar in
            guard let self = self else { return }
            if resChar?.results != nil, let persons = resChar?.results {
                self.dataSource = persons.map {
                    CharacterCell.Model(title: $0.name ?? "None", image: $0.image, id: $0.id ?? 0,
                                        episode: $0.episode, status: $0.status ?? "None",
                                        species: $0.species ?? "None", typeCreated: $0.typeCreated ?? "None",
                                        gender: $0.gender ?? "None", namePlanet: $0.origin.name ?? "None",
                                        urlLocation: $0.origin.url ?? "None")
                }
                self.output?.updateTableView(with: self.dataSource)
            }
        }
    }

    func didSelectCell(at index: Int) {
        let detailVC = DetailVC()
        let presenter = DetailVCPresenter(character: dataSource[index])
        presenter.output = detailVC
        detailVC.presenter = presenter

        output?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
