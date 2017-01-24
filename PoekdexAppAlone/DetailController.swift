//
//  DetailController.swift
//  PoekdexAppAlone
//
//  Created by Scripter on 23/01/17.
//  Copyright © 2017 Scripter. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var pokemonNameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonNameLbl.text = self.pokemon.name
        
    }

    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
