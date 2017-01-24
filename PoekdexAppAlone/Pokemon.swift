//
//  Pokemon.swift
//  PoekdexAppAlone
//
//  Created by Scripter on 20/01/17.
//  Copyright © 2017 Scripter. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokeID: Int!
    
    var name: String {
        return _name
    }
    
    var pokeID: Int {
        return _pokeID
    }
    
    init(pokeName: String, pokeID: Int) {
        self._name = pokeName
        self._pokeID = pokeID
    }
}
