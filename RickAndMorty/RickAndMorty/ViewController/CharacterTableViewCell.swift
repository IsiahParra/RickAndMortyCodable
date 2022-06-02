//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Isiah Parra on 6/1/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterNameLabel: UILabel!
    
    var image: UIImage? {
        didSet{
            setNeedsUpdateConfiguration()
        }
    }
    
    
    func setConfiguration(with character: ResultsDictionary) {
        fetchImage(for: character)
       var configuration = defaultContentConfiguration()
        configuration.text = character.name
        configuration.secondaryText = character.species
        configuration.imageProperties.maximumSize = CGSize(width: 125, height: 160)
        contentConfiguration = configuration
    }
    
    func fetchImage(for character: ResultsDictionary) {
        guard let imageString = character.imageString else {return}
        NetworkController.fetchImage(for: imageString) { result in
            switch result {
            case.success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case.failure(let error):
                    print("there has been an error", error.errorDescription!)
            
        }
    }
//
//
//    func fetchCharacter(for character: ResultsDictionary) {
//        NetworkController.fetchCharacter(with: character.name) { results in
//            switch results {
//            case.success(let character):
//                DispatchQueue.main.async {
//                    self.characterNameLabel.text = character.name
//                }
//            case.failure(let error):
//                print("theres been an .... *BurRrP* error Morty!", error.errorDescription!)
//            }
//        }
//    }
    
    }
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        guard var configuration = contentConfiguration as? UIListContentConfiguration else { return }
        configuration.image = self.image
        contentConfiguration = configuration
    }
    
    
}// End of class
