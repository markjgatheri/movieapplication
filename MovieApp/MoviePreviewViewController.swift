//
//  MoviePreviewViewController.swift
//  MovieApp
//
//  Created by Apple on 08/04/2017.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class MoviePreviewViewController: UIViewController {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var txtMovieName: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    
    
    
   var name:String?
    var movieType:String?
    var imageurl:String?
    var id:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtMovieName.text = name!
        txtDescription.text = name!
        
          let url = URL(string: imageurl!)!
        imgPoster.kf.setImage(with: url,
                                   placeholder: nil,
                                   options: [.transition(ImageTransition.fade(1))],
                                   progressBlock: { receivedSize, totalSize in
                                    print("1: ")
        },
                                   completionHandler: { image, error, cacheType, imageURL in
                                    print("1: ")
        })
        
    }

    
    
    
    
    @IBAction func btnAddToBookmark(_ sender: UIBarButtonItem) {
        
        addtoCart()
        
    }
    
    
    
    func addtoCart(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Bookmarks", into: context)
        
        newItem.setValue(movieType!, forKey: "movietype")
        newItem.setValue(name, forKey: "moviename")
        newItem.setValue(id, forKey: "movieid")
        newItem.setValue(imageurl!, forKey: "imageurl")
        
        do {
            try context.save()
            print("Saved")
            addedToBookmarksAlert()
            
        } catch {
            print("There was an error")
            
        }
        
        
        
    }
    
    
    
    
    func addedToBookmarksAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "", message: "Added to bookmarks", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            
        }
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    

}
