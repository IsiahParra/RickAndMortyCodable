//
//  CharactersListTableViewController.swift
//  RickAndMorty
//
//  Created by Isiah Parra on 6/1/22.
//

import UIKit

class CharactersListTableViewController: UITableViewController {

    var characterList: [ResultsDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characterList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else {return UITableViewCell()}
        let character = characterList[indexPath.row]
        
        return cell
    }
    

    // MARK: - Navigation

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
