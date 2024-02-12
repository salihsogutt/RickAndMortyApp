//
//  DetayVC.swift
//  RickAndMorty
//
//  Created by salih söğüt on 29.01.2024.
//

import UIKit
import CoreData

/*
core data kodlari appDelegate icerisine girildi.
ardindan core data iport edildi
daha sonra addfavorites button icinde veri kaydetme kodlari girildi
sonra FavoriVC de get data func icinde veri cekme islemleri yapildi ve tableView de gosterildi
*/



class DetayVC: UIViewController {
    
    @IBOutlet weak var detayCharacterImage: UIImageView!
    @IBOutlet weak var detayCharacterGenderLabel: UILabel!
    @IBOutlet weak var detayCharacterNameLabel: UILabel!
    @IBOutlet weak var viewDetay: UIView!
    
    var karakter:Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detayCharacterImage.layer.cornerRadius = 15
        viewDetay.layer.cornerRadius = 15
        
        
        detayCharacterNameLabel.text = karakter.name
        detayCharacterGenderLabel.text = karakter.gender
         
        if let url = URL(string: karakter.image ??  ""){
            DispatchQueue.main.async {
                self.detayCharacterImage.kf.setImage(with: url)
            }
        }
    }
    
    @IBAction func addFavoritesButton(_ sender: Any) {
        
        //Veri kaydetme işlemi
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "CharacterModel", into: context)
        
        saveData.setValue(karakter.name, forKey: "name")
        saveData.setValue(karakter.image, forKey: "image")
        
        do {
            try context.save()
            print("succes")
        }catch{
            print("error")
        }
        
        Alert()
        
    }
    
    func Alert() {
        let alertController = UIAlertController(title: "Added to Favorites", message: "", preferredStyle: .alert)
        
        let tamamActtion = UIAlertAction(title: "Ok", style: .destructive){
            action in
            
            self.navigationController?.popViewController(animated: true)//tamama tiklandiginda
            
            print("tiklandi")
        }
        
        alertController.addAction(tamamActtion)//tamam button contoroller a ekler
        
        self.present(alertController,animated: true)//buttonu gosterir, ayni zamanda herhangi bir view i gosterebiliriz
    }
    
    
}
