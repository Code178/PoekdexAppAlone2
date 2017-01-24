//
//  ViewController.swift
//  PoekdexAppAlone
//
//  Created by Scripter on 20/01/17.
//  Copyright © 2017 Scripter. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    var filteredPokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        parseCSV()
        initAudio()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text?.lowercased()
            filteredPokemons = pokemons.filter({$0.name.range(of: lower!) != nil })
            collectionView.reloadData()
        }
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "10polkamon", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err)
        }
        
    }
    func parseCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeId = Int(row["id"]!)
                let pokeName = row["identifier"]
                let pokemon = Pokemon(pokeName: pokeName!, pokeID: pokeId!)
                pokemons.append(pokemon)
            }
        } catch let err as NSError {
            print(err)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell
        if inSearchMode {
           let poke = filteredPokemons[indexPath.row]
            cell?.configureCell(pokemon: poke)
        } else {
            let poke = pokemons[indexPath.row]
            cell?.configureCell(pokemon: poke)
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode { return filteredPokemons.count }
        
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemons[indexPath.row]
        } else {
            poke = pokemons[indexPath.row]
        }
        performSegue(withIdentifier: "showDetail", sender: poke)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destination = segue.destination as? DetailController {
                if let poke = sender as? Pokemon {
                    destination.pokemon = poke
                }
            }
        }
    }
}

