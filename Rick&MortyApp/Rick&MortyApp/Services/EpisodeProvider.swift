//
//  EpisodeProvider.swift
//  Rick&MortyApp
//
//  Created by user on 21.08.2023.
//

final class EpisodeProvider {

    var dataEpisodes = [episodeDetail]()
    var dataWithCharacter = [episodeDetail]()

    func getSeriesInNetwork(netQuest: NetworkService, completion: @escaping ([episodeDetail]) -> () ) {
        netQuest.getUrlList { [weak self] urlListData in
            netQuest.getEpisodesDetail(urlString: urlListData?.episodes ?? "nil")
            { [weak self] resEpisode in
                guard let self = self else { return }
                if resEpisode?.results != nil, let episodes = resEpisode?.results {
                    self.dataEpisodes = episodes
                    completion(self.dataEpisodes)
                }
            }
        }

    }

    func seriesWithCharacter(id: [Int]) {
        for elOfChar in id {
            for elOfEpisode in dataEpisodes {
                if elOfEpisode.id == elOfChar {
                    dataWithCharacter.append(elOfEpisode)
                }
            }
        }
    }

    

}

