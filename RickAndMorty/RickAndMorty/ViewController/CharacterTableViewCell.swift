//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Isiah Parra on 6/1/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterNameLabel: UILabel!
    
    
    func updateViews(with name: String) {
        NetworkController.fetchCharacter(with: name) { results in
            switch results {
            case.success(let character):
                self.fetchCharacter(for: character)
            case.failure(let error):
                print("theres been an .... *BurRrP* error Morty!", error.errorDescription!)
            }
        }
    }
    
    
    func fetchCharacter(for character: ResultsDictionary) {
        NetworkController.fetchCharacter(with: character.name) { results in
            switch results {
            case.success(let character):
                DispatchQueue.main.async {
                    self.characterNameLabel.text = character.name
                }
            case.failure(let error):
                print("theres been an .... *BurRrP* error Morty!", error.errorDescription!)
            }
        }
    }
    

}// End of class
