//
//  FavoriVC.swift
//  RickAndMorty
//
//  Created by salih söğüt on 2.02.2024.
//

import UIKit
import CoreData

class FavoriVC: UIViewController {
    
    @IBOutlet weak var favoriTableView: UITableView!
    
    var characterList = [CharacterModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriTableView.dataSource = self
        favoriTableView.delegate = self
        
        getData()
    }
    
    func getData() {
        
        self.characterList.removeAll(keepingCapacity: true)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CharacterModel")
        fetchRequest.returnsObjectsAsFaults = false //performans arttiriyormus
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [CharacterModel] {
                
                characterList.append(result)
                self.favoriTableView.reloadData()
                }
            }catch{
        }
    }
}
                                                                

extension FavoriVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoriTableView.dequeueReusableCell(withIdentifier: "favoriCell") as! FavoriTableViewCell
        
        cell.favoriCellLabel.text = characterList[indexPath.row].name
        
        let url = URL(string: characterList[indexPath.row].image ?? "")
            DispatchQueue.main.async {
                cell.favoriCellImage.kf.setImage(with: url)
            }
        
        cell.layer.cornerRadius = 15
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHeight: CGFloat = 100
        let spacingHeight: CGFloat = 0
        
        return cellHeight + spacingHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil") {
            UIContextualAction, view, bool in
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
