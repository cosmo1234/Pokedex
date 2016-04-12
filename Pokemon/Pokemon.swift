//
//  Pokemon.swift
//  Pokemon
//
//  Created by sagaya Abdulhafeez on 12/04/2016.
//  Copyright © 2016 sagaya Abdulhafeez. All rights reserved.
//

import Foundation

class Pokemon{
    
    private var _name: String!
    private var _pokedxId: Int!
    
    
    var name:String{
        return _name
    }
    
    var pokedexId:Int{
        return _pokedxId
    }
    
    
    init(name:String, pokedexId:Int ){
        
        _name = name
        _pokedxId = pokedexId
        
    }
    
}