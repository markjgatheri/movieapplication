//
//  MoreViewController.swift
//  MovieApp
//
//  Created by Apple on 08/04/2017.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var nameArray: [String] = ["About","Help","Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MoreTableViewCell
        
        Cell.txtName?.text = "\(nameArray[indexPath.row])"
        
        return Cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red:0.18, green:0.16, blue:0.16, alpha:1.0)
        
        if (indexPath.row == 0){
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        
        if (indexPath.row == 1){
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
            
        }
        if (indexPath.row == 2){
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        
        
    }

    
    
    
    

}
