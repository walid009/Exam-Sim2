//
//  AcceuilTableViewController.swift
//  sim222walid
//
//  Created by chekir walid on 16/11/2021.
//

import UIKit

class AcceuilTableViewController: UITableViewController {
    var name = ["Alisson Becker", "Andy Robertson", "Fabinho Tavares", "Gini Wijnaldum","James Milner", "Joe Gomez", "Jordan Henderson", "Mohamed Salah", "Roberto Firmino", "Sadio Mane", "Trent Alexander Arnold", "Virgil Van Dijk", "Adrian"]
    var tab = ["GK", "LB", "CDM", "CM","CM", "CB", "CDM", "RW", "CF", "LW", "RB", "CB", "GK"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return name.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let context = cell?.contentView
        
        let image = context?.viewWithTag(1) as! UIImageView
        let label1 = context?.viewWithTag(2) as! UILabel
        let label2 = context?.viewWithTag(3) as! UILabel
        
        image.image = UIImage(named: name[indexPath.row])
        label1.text = name[indexPath.row]
        label2.text = tab[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let indexPath = sender as! IndexPath
            let vc = segue.destination as! DetailViewController
            vc.name = name[indexPath.row]
        }
    }

    @IBAction func showTopPlayer(_ sender: Any) {
        self.performSegue(withIdentifier: "showTopPlayer", sender: sender)
    }
    
}
