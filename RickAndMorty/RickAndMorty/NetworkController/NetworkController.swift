//
//  NetworkController.swift
//  RickAndMorty
//
//  Created by Isiah Parra on 6/1/22.
//

import Foundation

class NetworkController {
    
    private static let baseURLString = "https://rickandmortyapi.com/api"
    
    //endpoint 1
    static func fetchTopLevelDictionary(with url: URL, completion: @escaping(Result<TopLevelDictionary, ResultError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                print("Encountered Error: \(error.localizedDescription)")
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do{
                let characterDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(characterDictionary))
            }catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    //Endpoint2
    
}// End of class
