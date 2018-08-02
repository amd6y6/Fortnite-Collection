//
//  SideMenuTableViewController.swift
//  FortniteCollection
//
//  Created by Austin Dotto on 7/26/18.
//  Copyright © 2018 Austin Dotto. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

 
    
    
    var sideMenuArray = ["Skins", "Emotes", "Gliders", "Pickaxe", "Back Bling", "Contrails", "Loading Screens","Sprays","Account", "About"]
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("showSideMenu"), object: nil)
        
        switch indexPath.row  {
        case 0: NotificationCenter.default.post(name: NSNotification.Name("showSkins"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("showEmotes"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("showGliders"), object: nil)
        case 3: NotificationCenter.default.post(name: NSNotification.Name("showPickaxe"), object: nil)
        case 4: NotificationCenter.default.post(name: NSNotification.Name("showBackBling"), object: nil)
        case 5: NotificationCenter.default.post(name: NSNotification.Name("showContrails"), object: nil)
        case 6: NotificationCenter.default.post(name: NSNotification.Name("showLoadingScreens"), object: nil)
        case 7: NotificationCenter.default.post(name: NSNotification.Name("showSprays"), object: nil)
        case 8: NotificationCenter.default.post(name: NSNotification.Name("showAccount"), object: nil)
        case 9: NotificationCenter.default.post(name: NSNotification.Name("showAbout"), object: nil)
        default: break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sideMenuArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = sideMenuArray[indexPath.row]
        
        return cell
    }
    
    
}



