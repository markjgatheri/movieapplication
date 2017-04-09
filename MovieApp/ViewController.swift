//
//  ViewController.swift
//  MovieApp
//
//  Created by Apple on 07/04/2017.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import RappleProgressHUD

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = [String]()
    var idArray = [String]()
    var imageArray = [String]()
    var typeArray = [String]()
    
    var refresher: UIRefreshControl!
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(Reachability.isConnectedToNetwork() == false){
            DispatchQueue.main.async {
                LoadingBarViewController.displayMyAlertMessage(targetVC: self,userMessage: "No internet Connection")
                
            }
        }
            
        else if(titleArray.count < 1) {
            loadMovies()
            refresher = UIRefreshControl()
            refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refresher.addTarget(self, action: #selector(ViewController.loadMovies), for: UIControlEvents.valueChanged)
            tableView.addSubview(refresher)
            
        }
        else{
            self.tableView.reloadData()
        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let returnValue = titleArray.count
        
        if(returnValue == 0){
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "No movies found"
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
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        
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

    
    
    
    
    func loadMovies(){
       
        DispatchQueue.main.async {
            RappleActivityIndicatorView.startAnimatingWithLabel("Loading...", attributes: RappleModernAttributes)
            
        }
        request("\(URL_BASE)", method: .get, parameters: nil).responseJSON { response in
            DispatchQueue.main.async {
                RappleActivityIndicatorView.stopAnimating()
                
            }
            
            // make sure we got some JSON since that's what we expect
            guard let json = response.result.value as? [String: AnyObject] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(response.result.error!)")
                return
            }
            
            // get and print the title
            guard let status_response = json["Response"] as? String else {
                print("Could not get status title from JSON")
                return
            }
            print(json)
            
            if(status_response != "True"){
                DispatchQueue.main.async {
                LoadingBarViewController.displayMyAlertMessage(targetVC: self,userMessage: "No Movies available")
                }
                
            }else{
                
                //month
                guard let movieData =  json["Search"] as? NSArray else{
                    return
                }
                
                if(movieData.count >= 1){
                    
                    self.clearArrays()
                    self.tableView.backgroundView?.isHidden = true
                    for item in movieData{
                        if let title = (item as AnyObject).value(forKey:"Title") as? String {
                            self.titleArray.append(title)
                        }
                        if let id = (item as AnyObject).value(forKey:"imdbID") as? String {
                            self.idArray.append(id)
                        }
                        if let movietype = (item as AnyObject).value(forKey:"Type") as? String {
                            self.typeArray.append(movietype)
                        }
                        if let poster = (item as AnyObject).value(forKey:"Poster") as? String {
                            self.imageArray.append(poster)
                        }
                        
                    }
                    
                }else{
                    self.tableView.backgroundView?.isHidden = false
                }
                self.refresher.endRefreshing()
                
                self.tableView.reloadData()
                
                
            }
            
        }
        
        
        
    }
    
  func clearArrays(){
        titleArray.removeAll()
        idArray.removeAll()
        imageArray.removeAll()
        typeArray.removeAll()
    }
    
    
    
    
    
    
    
    
    
    

}

