//
//  PokeCell.swift
//  PoekdexAppAlone
//
//  Created by Scripter on 20/01/17.
//  Copyright © 2017 Scripter. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemonName.text = pokemon.name.capitalized
        self.thumbImg.image = UIImage(named: "\(pokemon.pokeID)")
    }
    
}
