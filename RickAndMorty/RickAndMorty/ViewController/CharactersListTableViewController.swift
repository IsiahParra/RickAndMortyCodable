//
//  CharactersListTableViewController.swift
//  RickAndMorty
//
//  Created by Isiah Parra on 6/1/22.
//

import UIKit

class CharactersListTableViewController: UITableViewController {
    
    var characterList: [ResultsDictionary] = []
    var topLevelDictionary: TopLevelDictionary?
    
    @IBOutlet weak var characterSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterSearchBar.delegate = self
        NetworkController.fetchTopLevelDictionary(with: URL(string: "https://rickandmortyapi.com/api/character")!) { [weak self] result in
            switch result {
            case.success(let topLevelDictionary):
                self?.topLevelDictionary = topLevelDictionary
                self?.characterList = topLevelDictionary.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print("Oh no there has been an error!", error.errorDescription!)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characterList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else {return UITableViewCell()}
        
        let character = characterList[indexPath.row]
        cell.setConfiguration(with: character)
        
        return cell
    }
    //MARK: - PAGENATION
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let topLevelDictionary = topLevelDictionary,
            let nextURL = URL(string: topLevelDictionary.info.next) else {return}
        

        let lastCharacteIndex = characterList.count - 1
        // first i need to know when the TBV is near the bottom. i can discover that by counting the amount of objects in my SOT.
        if indexPath.row == lastCharacteIndex {
            // Second i need to make a new network call to fetch the next set of 20 characters *the url must be the right one*.
            NetworkController.fetchTopLevelDictionary(with: nextURL) { result in
                switch result {
                case.success(let topLevelDict):
                    self.topLevelDictionary = topLevelDict
                    self.characterList.append(contentsOf: topLevelDictionary.results)
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                case.failure(let error):
                    print("An error has been detected, Morty we need to .. BuuRRp go.", error.errorDescription!)
                }
            }
        }
        // third i need to add those new characters (resultDictionary) to my SOT
        
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? CharacterDetailViewController {
                    let characterToSend = characterList[indexPath.row]
                    destination.character = characterToSend
                    
                }
            }
        }
    }
    
}// End of class

extension CharactersListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      guard let url = URL(string: "https://rickandmortyapi.com/api/character?name=\(searchText)") else {return}
        NetworkController.fetchTopLevelDictionary(with: url) { [weak self] result in
                switch result {
                case.success(let topLevelDictionary):
                    self?.topLevelDictionary = topLevelDictionary
                    self?.characterList = topLevelDictionary.results
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case.failure(let error):
                    print("Oh no there has been an error!", error.errorDescription!)
                }
        }
    }
}


