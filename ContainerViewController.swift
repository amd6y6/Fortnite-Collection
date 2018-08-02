//
//  ContainerViewController.swift
//  FortniteCollection
//
//  Created by Austin Dotto on 7/26/18.
//  Copyright © 2018 Austin Dotto. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainContainer: UIView!
    var menuActive = false
    
    
    @objc func showSideMenu(){
        if menuActive{
            sideMenuConstraint.constant = -166
            menuActive = false
        }
        else {
            sideMenuConstraint.constant = 0
            menuActive = true
        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSideMenu),
                                               name: NSNotification.Name("showSideMenu"),
                                               object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
