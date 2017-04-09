//
//  SignInViewController.swift
//  MovieApp
//
//  Created by Apple on 08/04/2017.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import UIKit
import Alamofire
import RappleProgressHUD

class SignInViewController: UIViewController {

    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
  
    @IBAction func btnLogin(_ sender: UIButton) {
            
            self.view.endEditing(true)
            let userName = txtUsername.text;
            let userPassword = txtPassword.text;
            
            if((userName?.isEmpty)! || (userPassword?.isEmpty)!){
                LoadingBarViewController.displayMyAlertMessage(targetVC: self,userMessage: "Please fill all fields");
            }
            else if(Reachability.isConnectedToNetwork() == false){
                DispatchQueue.main.async {
                    LoadingBarViewController.displayMyAlertMessage(targetVC: self,userMessage: "No internet Connection")
                    
                }
            }
            else{
                let myParameters = ["username": "\(userName!)", "password": userPassword!]
                DispatchQueue.main.async {
                    RappleActivityIndicatorView.startAnimatingWithLabel("Loading...", attributes: RappleModernAttributes)
                }
                request("\(URL_BASE)/login.php", method: .post, parameters: myParameters).responseJSON { response in
                    DispatchQueue.main.async {
                        RappleActivityIndicatorView.stopAnimating()
                    }
                   
                    let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = myTabBar
                    
                    
                    
                }
            }
            
            
        }

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   

}
