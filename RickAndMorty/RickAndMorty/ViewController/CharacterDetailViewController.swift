//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Isiah Parra on 6/1/22.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    }
    
    
    
    var character: ResultsDictionary? {
        didSet {
            updateViews()
        }
    }
    var origin: OriginDictionary? {
        didSet{
            updateViews()
        }
    }
    var location: LocationDictionary? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let character = character else {
            return
        }
        
                //fetch the image
        NetworkController.fetchImage(for: character.imageString ?? "") { results in
                    switch results{
                    case.success(let image):
                        DispatchQueue.main.async {
                            self.characterImageView.image =  image
                        }
                    case .failure(let error):
                        print("There has been an error", error.errorDescription!)
                    }
                }
        self.character = character
        self.nameLabel.text = character.name
        self.locationLabel.text = self.location?.name
        self.speciesLabel.text = character.species
        self.genderLabel.text = character.gender
        self.originLabel.text = self.origin?.name
        self.idLabel.text = "\(character.id)"
        self.statusLabel.text = character.status
            }
    
}//end of class
