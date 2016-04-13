//
//  detailViewController.swift
//  Pokemon
//
//  Created by sagaya Abdulhafeez on 12/04/2016.
//  Copyright © 2016 sagaya Abdulhafeez. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentevoImg: UIImageView!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var IdLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionlABL: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        test.text = pokemon.name
        mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
            //CALL THE UPDATE UI
            self.updateUi()
            
        }
    }
    
    
    func updateUi(){
        
        descriptionlABL.text = pokemon.desc
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        IdLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
        currentevoImg.image = UIImage(named: "\(pokemon.pokedexId)")
        
        if pokemon.nextEvoId == ""{
            evoLbl.text = "NO EVOLUTIONS"
            nextEvoImg.hidden = true
        }else{
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            var strin = "NEXT EVOLUTION: \(pokemon.nextEvo)"
            
            if pokemon.nextEvoLvl != ""{
                
                strin += "- LVL \(pokemon.nextEvoLvl)"
            }
            
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwind(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }


}
