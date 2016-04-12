//
//  ViewController.swift
//  Pokemon
//
//  Created by sagaya Abdulhafeez on 12/04/2016.
//  Copyright © 2016 sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!

    var pokemon =   [Pokemon]()
    var filteredPokimon = [Pokemon]()
    var musicPlayer:AVAudioPlayer!
    var inSearchMode = false
    
    
    
    @IBAction func music(sender: UIButton!) {
        
        if musicPlayer.playing{
            musicPlayer.stop()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.2
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        initAudio()
        
        parsePokimon()
    }
    
    
    //PATRSE THE POKEMON AND APPEND THEM TO THE ARRAY "POKEMON"
    func parsePokimon(){
        
        //GET THE FILE NSBUNDLE
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do{
            //USE THE CSV FILE FRAMEWORK UPLOADED
            let csv = try CSV(contentsOfURL: path)
            
            //GET ALL THE ROWS EACH ROW HAS ID AND ALL THOSE STUFFS
            let rows = csv.rows
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]
                let poke = Pokemon(name: name!, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
        }catch{
            print("ERROR!")
        }
        
    }
    
    
    func initAudio(){
        
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 //infinite
            musicPlayer.play()
        }catch{
            print("ERROR!")
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? pokeCollectionViewCell{
            
            var poke:Pokemon!
            
            if inSearchMode{
                poke = filteredPokimon[indexPath.row]
            }else{
                poke = pokemon[indexPath.row]

            }
            
            
            cell.configureCell(poke)
            
            
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredPokimon.count
        }
        
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
        
    }
    
    
    //SEARCHBAR STUFFS
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text ==  ""{
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        }else{
            inSearchMode = true
            
            let lower = searchBar.text!.lowercaseString
            
            filteredPokimon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            
            collectionView.reloadData()
        }
        
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

