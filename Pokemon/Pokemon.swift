//
//  Pokemon.swift
//  Pokemon
//
//  Created by sagaya Abdulhafeez on 12/04/2016.
//  Copyright © 2016 sagaya Abdulhafeez. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    private var _name: String!
    private var _pokedxId: Int!
    private var _desc:String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvo:String!
    private var _nextEvoId:String!
    private var _nextEvoLvl:String!
    private var _pokemonUrl:String!
    
    
    
    var name:String{
        return _name
    }
    
    var pokedexId:Int{
        return _pokedxId
    }

    var desc:String{
        
            if _desc == nil{
                _desc =  ""
            }
            return _desc
        }

    
    
    var type:String{
        
            if _type == nil{
                _type =  ""
            }
            return _type
        }

    
    
    var defense:String{
        
            if _defense == nil{
                _defense =  ""
            }
            return _defense
        }


    
    
    var height:String{
        
            if _height == nil{
                _height =  ""
            }
            return _height
        }


    
    var weight:String{
        
            if _weight == nil{
                _weight =  ""
            }
            return _weight
        }


    
    
    var attack:String{
        
            if _attack == nil{
                _attack =  ""
            }
            return _attack
        }


    
    var nextEvo:String{
        
            if _nextEvo == nil{
                _nextEvo =  ""
            }
            return _nextEvo
        }


    
    var nextEvoId:String{
        
            if _nextEvoId == nil{
                _nextEvoId =  ""
            }
            return _nextEvoId
        }


    
    
    var nextEvoLvl:String{
        
            if _nextEvoLvl == nil{
                 _nextEvoLvl =  ""
            }
        return _nextEvoLvl
    }
    
    var pokemonUrl:String{
        return _pokemonUrl
    }
    
    init(name:String, pokedexId:Int ){
        
        _name = name
        _pokedxId = pokedexId
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedxId)"
        
    }
    
    //DOWNLOADcOMPLETE IS A CLOSURE IN CONSTANTS FILE
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)
        Alamofire.request(.GET, url!).responseJSON { (response) in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                
                //types is an array of dictionaries of type string string
                //THE WHERE STATEMENT CHECKS IF TYPES IS GREATER THAN O
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0{
                
                    //GETTING THE FIRST ITEM IN IT WITH INDEX 0 AND THE KEY NAME
                    if let name = types[0]["name"]{
                        self._type = name.capitalizedString
                    }
                    
                    //TO GET THE SECOND ITEM AND ADD THE / THING
                    if types.count > 1{
                        for var x = 1; x < types.count; ++x{
                            
                            if let name = types[x]["name"]{
                                self._type! += "/\(name)".capitalizedString
                            }
                            
                        }
                    }else{
                        self._type = ""
                    }
                    
                    print(self._type)
                    
                    
                    //GET THE DESCRIPTION
                    
                    if let descArray  = dict["descriptions"] as? [Dictionary <String,String>] where descArray.count > 0{
                        
                        if let url = descArray[0]["resource_uri"] {
                            
                            let nsurl = NSURL(string: "\(URL_BASE)\(url)")
                            Alamofire.request(.GET, nsurl!).responseJSON(completionHandler: { (response) in
                                
                                
                                let descResult = response.result
                                if let desDict = descResult.value as? Dictionary <String,AnyObject>{
                                    
                                    if let description = desDict["description"] as? String{
                                        self._desc = description
                                        print(self._desc)

                                    }
                                    
                                }
                                
                                completed()
                                
                            })
                            
                        }else{
                            self._desc = ""
                        }
                        
                        
                        
                        //GETTING EVOLUTION
                        
                        if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0{
                            
                            if let to = evolutions[0]["to"] as? String{
                                
                                if to.rangeOfString("mega") == nil{
                                    
                                    if let uri = evolutions[0]["resource_uri"] as? String{
                                        let nrewStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                        let num = nrewStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                        
                                        self._nextEvoId = num
                                        self._nextEvo = to
                                        
                                        if let level = evolutions[0]["level"] as? Int{
                                            self._nextEvoLvl = "\(level)"
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
            }
        }
        
        
    }
    
}