//
//  SignupViewController.swift
//  FortniteCollection
//
//  Created by Austin Dotto on 7/26/18.
//  Copyright © 2018 Austin Dotto. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUpButton(_ sender: Any) {
        if  password.text == ""  || username.text == "" || email.text == ""{
            
            displayAlert(title:"Error in signup", message:"Please fill out all required fields")
            
        }
        else {
            
            let user = PFUser()
            user.username = username.text?.lowercased()
            user.password = password.text
            user.email = email.text
            
            user.signUpInBackground(block: { (success, error) in
                
                
                if let error = error {
                    self.displayAlert(title: "Unable to sign up", message: error.localizedDescription)
                    
                } else {
                    
                    self.performSegue(withIdentifier: "showSkins", sender: self)
                    self.navigationController?.viewControllers = [self]
                    
                    
                }
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
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
