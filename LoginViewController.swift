//
//  LoginViewController.swift
//  FortniteCollection
//
//  Created by Austin Dotto on 7/26/18.
//  Copyright © 2018 Austin Dotto. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBAction func loginButton(_ sender: Any) {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityIndicator.center = self.view.center
        
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        PFUser.logInWithUsername(inBackground: (username.text?.lowercased())!, password: password.text!, block: { (user, error) in
            
            if user != nil {
                
                
                let main = UIStoryboard(name: "Main", bundle: nil)
                let first = main.instantiateViewController(withIdentifier: "Container")
                self.present(first,animated: true, completion: nil)
                
                
                
                
                
                self.navigationController?.isNavigationBarHidden = true
                
            } else {
                
                var errorText = "Unknown error: please try again"
                if let error = error {
                    errorText = error.localizedDescription
                    
                }
                self.displayAlert(title: "Unsuccessul login", message: errorText)
            }
        })
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
