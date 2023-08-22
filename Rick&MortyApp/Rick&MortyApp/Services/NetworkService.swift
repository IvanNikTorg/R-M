//
//  NetworkService.swift
//  Rick&MortyApp
//
//  Created by user on 20.08.2023.
//

import Foundation

struct UrlList: Codable {
    let characters: String?
    let locations: String?
    let episodes: String?
}

struct resultCharacters: Codable {
    let info: InfoForCharacterData?
    let results: [Person]?
}

struct InfoForCharacterData: Codable {
    let countCharacters: Int?
    let pages: Int?
}

struct Person: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let typeCreated: String?
    let gender: String?
    let origin: OriginStruct
    let image: String?
    let episode: [String]?
}

struct OriginStruct: Codable {
    let name: String?
    let url: String?
}

struct ResultId: Codable {
    let namePlanet: String?
    let type: String?
    let dimention: String?
    let created: String?
}

struct EpisodeRM: Codable {
    let results: [EpisodeDetail]?
}

struct EpisodeDetail: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
}

class NetworkService {

    static let shared = NetworkService()
    private init() {}
    
    private let startUrl = "https://rickandmortyapi.com/api"
    
    private func getUrlList(completion: @escaping (UrlList?) -> () ) {
        guard let url = URL(string: startUrl) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let urlList = try JSONDecoder().decode(UrlList.self, from: data)
                completion(urlList)
            } catch let error {
                print(error)
            }
        }.resume()
    }

    func getCharacterList(completion: @escaping (resultCharacters?) -> () ) {
        getUrlList { urlList  in
            guard let urlString = urlList?.characters, let url = URL(string: urlString) else {
                completion(nil)
                return
            }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                do {
                    let urlList = try JSONDecoder().decode(resultCharacters.self, from: data)
                    completion(urlList)
                } catch let error {
                    print(error)
                }
            }.resume()
        }
    }

    func getDataFromDetail(urlString: String, completion: @escaping (ResultId?) -> () ) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let urlList = try JSONDecoder().decode(ResultId.self, from: data)
                completion(urlList)
            } catch let error {
                print(error)
            }
        }.resume()
    }

    func getEpisodesDetail(completion: @escaping (EpisodeRM?) -> ()) {
        getUrlList { urlList  in
            guard let urlString = urlList?.episodes, let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                do {
                    let urlList = try JSONDecoder().decode(EpisodeRM.self, from: data)
                    completion(urlList)
                } catch let error {
                    print(error)
                }
            }.resume()
        }
    }
}
