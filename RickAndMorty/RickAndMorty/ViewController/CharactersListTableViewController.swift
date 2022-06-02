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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

//MARK: TO DO FOR DAY 2

// figure out why our images are at a default size until they reQue to the new size

// we need pagination to view more than 20 characters

//we need our search bar on the table view controller


