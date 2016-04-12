//
//  pokeCollectionViewCell.swift
//  Pokemon
//
//  Created by sagaya Abdulhafeez on 12/04/2016.
//  Copyright © 2016 sagaya Abdulhafeez. All rights reserved.
//

import UIKit

class pokeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeLabel: UILabel!
    
    var pokemon: Pokemon!
    
    //INITIALIZERS
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(pokemon: Pokemon){
        
        self.pokemon = pokemon
        
        pokeLabel.text = self.pokemon.name.capitalizedString
        pokeImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
}
