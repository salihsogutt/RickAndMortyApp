//
//  ViewController.swift
//  RickAndMorty
//
//  Created by salih söğüt on 27.01.2024.
//

import UIKit
import Alamofire
import Kingfisher

class AnasayfaVC: UIViewController{
    
    @IBOutlet weak var searchBarAnasayfa: UISearchBar!
    @IBOutlet weak var rickAndMortyTableView: UITableView!
    var characterResponse = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rickAndMortyTableView.delegate = self
        rickAndMortyTableView.dataSource = self
        
        searchBarAnasayfa.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadJsonData()
    }
    
      func loadJsonData(){
          
          NetworkManager.shared.loadJsonData { response in
              self.characterResponse = response.results ?? []
              self.rickAndMortyTableView.reloadData()
          }
     }
    
    func aramaYap(aramaKelimesi:String) {
        
        let parametreler:Parameters = ["name":aramaKelimesi]
        let apiURL = "https://rickandmortyapi.com/api/character"
        
        AF.request(apiURL, method: .post, parameters: parametreler).response {
            response in
                if let data = response.data {
                        do {
                            let json = try JSONDecoder().decode(RickAndMorty.CharacterResponse.self, from: data)
                            if let gelenKisilistesi = json.results{
                                self.characterResponse = gelenKisilistesi
                            }else{
                                self.characterResponse = [Character]()
                            }
                            DispatchQueue.main.async {
                                self.rickAndMortyTableView.reloadData()
                            }
                        } catch {
                            print("JSON decode hatası: \(error)")
                    }
                }
            }
    }
}

extension AnasayfaVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rickAndMortyTableView.dequeueReusableCell(withIdentifier: "cellHucre", for: indexPath) as! AnasayfaTableViewCell
        
        cell.characterNameLabel.text = characterResponse[indexPath.row].name
        cell.characterGenderLabel.text = characterResponse[indexPath.row].gender
        cell.characterSituationLabel.text = characterResponse[indexPath.row].status
        
        if let url = URL(string: characterResponse[indexPath.row].image ??  ""){
            DispatchQueue.main.async {
                cell.characterImage.kf.setImage(with: url)
            }
        }
        
        cell.backgroundColor = UIColor.orange
        cell.layer.cornerRadius = 15
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        if let date = dateFormatter.date(from: characterResponse[indexPath.row].created ?? "") {
            let dateString = dateFormatter.string(from: date)
            
            cell.characterCreatedLabel.text = dateString
        }
        
        return cell
        
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHeight: CGFloat = 120
        let spacingHeight: CGFloat = 20
        
        return cellHeight + spacingHeight
    }    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let karakter = characterResponse[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: karakter)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetay" {
                if let karakter = sender as? Character {
                    let gidilecekVC = segue.destination as! DetayVC
                    gidilecekVC.karakter = karakter
                }else{
                    print("Nil geldi")
                }
            }
        }
}

extension AnasayfaVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        aramaYap(aramaKelimesi:searchText)
    }
    
}
