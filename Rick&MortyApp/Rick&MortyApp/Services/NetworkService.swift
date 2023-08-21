//
//  NetworkService.swift
//  Rick&MortyApp
//
//  Created by user on 20.08.2023.
//

import Foundation

//{"characters":"https://rickandmortyapi.com/api/character","locations":"https://rickandmortyapi.com/api/location","episodes":"https://rickandmortyapi.com/api/episode"}

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

struct resultId: Codable {
    let namePlanet: String?
    let type: String?
    let dimention: String?
    let created: String?
}

struct location: Codable {
    let id: Int
    let name: String?
    let type: String?
    let dimension: String?
}

struct episodeRM: Codable {
    let results: [episodeDetail]?
}

struct episodeDetail: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
}

class NetworkService {
    
    private let startUrl = "https://rickandmortyapi.com/api"
    
    func getUrlList( completion: @escaping (UrlList?) -> () ) {
        
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


    func getCharacterList(urlString: String, completion: @escaping (resultCharacters?) -> () ) {

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
                let urlList = try JSONDecoder().decode(resultCharacters.self, from: data)
                completion(urlList)
            } catch let error {
                print(error)
            }

        }.resume()

    }

    func getDataFromDetail(urlString: String, id: Int, completion: @escaping (resultId?) -> () ) {

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
                let urlList = try JSONDecoder().decode(resultId.self, from: data)
                completion(urlList)
            } catch let error {
                print(error)
            }
        }.resume()
    }



    func getEpisodesDetail(urlString: String, completion: @escaping (episodeRM?) -> () ) {

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
                let urlList = try JSONDecoder().decode(episodeRM.self, from: data)
                completion(urlList)
            } catch let error {
                print(error)
            }

        }.resume()

    }

}
