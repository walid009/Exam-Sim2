//
//  DetailViewController.swift
//  sim222walid
//
//  Created by chekir walid on 16/11/2021.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    var name:String?

    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var NomJoeur: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    @IBOutlet weak var Slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        Image.image = UIImage(named: name!)
        NomJoeur.text = name
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sliderClicked(_ sender: Any) {
        Quantity.text = String(Int(Slider.value))
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        if checkPalyer() {
            let alert = UIAlertController(title: "Message", message: "Player already add", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }else{
            addPlayer()
            let alert = UIAlertController(title: "Message", message: "Player add successfully", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func addPlayer() {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appdelegate.persistentContainer
        let managedContext = persistantContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Joeurs", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(name!, forKey: "name")
        object.setValue(String(Int(Slider.value)), forKey: "quantity")
        
        do{
            try managedContext.save()
            print("added successfully")
        }catch{
            print("error to insert")
        }
    }
    
    func checkPalyer() -> Bool {
        let appdelegare = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appdelegare.persistentContainer
        let mangedContext = persistantContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Joeurs")
        let predicate = NSPredicate(format: "name like %@", name!)
        request.predicate = predicate
        
        do {
            let result = try mangedContext.fetch(request)
            if result.count > 0 {
                return true
            }
        }catch{
            print("failed fetch")
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
