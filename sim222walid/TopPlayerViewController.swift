//
//  TopPlayerViewController.swift
//  sim222walid
//
//  Created by chekir walid on 16/11/2021.
//

import UIKit
import CoreData

class TopPlayerViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    var players = [String]()
    var rating = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        print(players.count)
    }
    
    func fetchData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistant = appDelegate.persistentContainer
        let managedcontext = persistant.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Joeurs")
        do {
            let data = try managedcontext.fetch(request)
            for p in data {
                if Int(p.value(forKey: "quantity") as! String)! > 7 {
                    players.append(p.value(forKey: "name") as! String)
                    rating.append(p.value(forKey: "quantity") as! String)
                }
            }
        }catch {
            print("error fetch")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellwalid", for: indexPath)
        let context = cell.contentView
        
        let image = context.viewWithTag(1) as! UIImageView
        let label = context.viewWithTag(2) as! UILabel
        
        image.image = UIImage(named: players[indexPath.row])
        label.text = rating[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if check() {
            let alert = UIAlertController(title: "Message", message: "you already voted ", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }else {
            insertMots(name: players[indexPath.row])
            let alert = UIAlertController(title: "Message", message: "you voted for \(players[ indexPath.row])", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func insertMots(name:String){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appdelegate.persistentContainer
        let managedContext = persistantContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Mots", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(name, forKey: "name")
        
        do{
            try managedContext.save()
            print("added successfully")
        }catch{
            print("error to insert")
        }
    }
    
    func check() -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistant = appDelegate.persistentContainer
        let managedcontext = persistant.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Mots")
        do {
            let data = try managedcontext.fetch(request)
            if data.count > 0 {
                return true
            }
        }catch {
            print("error fetch")
        }
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
