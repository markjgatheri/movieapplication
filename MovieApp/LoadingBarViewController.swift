//
//  LoadingBarViewController.swift
//  Taradi
//
//  Created by Apple on 22/02/2017.
//  Copyright © 2017 Masterpiece. All rights reserved.
//

import UIKit
import CoreData

class LoadingBarViewController {
    
    
    
    static func displayMyAlertMessage(targetVC: UIViewController,userMessage:String)
    {
        let myAlert = UIAlertController(title: "Lotela", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
        myAlert.addAction(okAction);
        targetVC.present(myAlert, animated: true, completion: nil);
    }
    
    func checkCart() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var hasItems = 0
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            if(results.count > 0){
                hasItems = 1
                
            }else{
              hasItems = 0
                
            }
        
        }catch{
            print("Could not fetch results")
            
        }
       
        if(hasItems == 1){
        return true
        }else{
            return false
        }
        
    }
    
    
    
    
  
}

