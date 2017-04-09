//
//  BookmarksViewController.swift
//  MovieApp
//
//  Created by Apple on 08/04/2017.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class BookmarksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var titleArray = [String]()
    var idArray = [String]()
    var imageArray = [String]()
    var typeArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewDidAppear(_ animated: Bool) {
         fetchBookmarks()
        //self.tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let returnValue = titleArray.count
        
        if(returnValue == 0){
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "No movies found in bookmarks"
            emptyLabel.textColor = UIColor.black
            emptyLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = emptyLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            return 0
        }else{
            return returnValue
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookmarksTableViewCell
        
        Cell.movieName?.text = "\(titleArray[indexPath.row])"
        let url = URL(string: "\(imageArray[indexPath.row])")!
        Cell.iconMovie.kf.setImage(with: url,
                                   placeholder: nil,
                                   options: [.transition(ImageTransition.fade(1))],
                                   progressBlock: { receivedSize, totalSize in
                                    print("\(indexPath.row + 1): ")
        },
                                   completionHandler: { image, error, cacheType, imageURL in
                                    print("\(indexPath.row + 1): ")
        })
        
        print("my_title_is \(titleArray[indexPath.row])")
        
        return Cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MoviePreviewViewController") as! MoviePreviewViewController
        
        secondViewController.name = titleArray[indexPath.row]
        secondViewController.movieType = typeArray[indexPath.row]
        secondViewController.imageurl = imageArray[indexPath.row]
        secondViewController.id = idArray[indexPath.row]
        
        // Take user to SecondViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    
    func fetchBookmarks(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookmarks")
        
        request.returnsObjectsAsFaults = false
        clearArrays()
        do{
            let results = try context.fetch(request)
            
            if(results.count > 0){
                
                for result in results as! [NSManagedObject]{
                    if let movietype = result.value(forKey: "movietype") as? String{
                        self.typeArray.append(movietype)
                    }
                    
                    if let moviename = result.value(forKey: "moviename") as? String{
                        print("This is my name \(moviename)")
                        self.titleArray.append(moviename)
                    }
                    
                    if let movieid = result.value(forKey: "movieid") as? String{
                        print("This is my movieid \(movieid)")
                        self.idArray.append(movieid)
                    }
                    if let imageurl = result.value(forKey: "imageurl") as? String{
                        print("This is my imageurl \(imageurl)")
                        self.imageArray.append(imageurl)
                    }
                    
                }
                
            }else{
                
            }
         
            print("size_of_array \(typeArray.count)")
            print("size_of_array \(titleArray.count)")
            print("size_of_array \(idArray.count)")
            print("size_of_array \(imageArray.count)")
            
            
        }catch{
            print("Could not fetch results")
            
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
    
    func clearArrays(){
        titleArray.removeAll()
        idArray.removeAll()
        imageArray.removeAll()
        typeArray.removeAll()
    }
    
    
    
    
    
    
}
