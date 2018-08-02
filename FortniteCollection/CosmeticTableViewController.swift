//
//  CosmeticTableViewController.swift
//  FortniteCollection
//
//  Created by Austin Dotto on 7/26/18.
//  Copyright © 2018 Austin Dotto. All rights reserved.
//

import UIKit
import Parse

class CosmeticTableViewController: UITableViewController {
    
    
    
    var menuActive = false
    var cosmeticTracker = "Skins"
    var cosmeticName = [String]()
    var cosmeticImage = [PFFile]()
    var cosmeticRarity = [String]()
    var cosmeticId = [String]()
    var obtained = [String]()
    var owned = "Owned"
    var cosmeticIdOwned = [String]()
    @IBOutlet var cosmeticTable: UITableView!
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch seg.selectedSegmentIndex {
        case 0:
            getAllCosmetics(cosmetic: cosmeticTracker)
        case 1:
            getOwnedCosmetics(cosmetic: cosmeticTracker)
        default:
            break;
        }
    }
    
    @IBOutlet weak var seg: UISegmentedControl!
    
    @IBAction func menuButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("showSideMenu"), object: nil)
        if menuActive == false {
            self.cosmeticTable.isUserInteractionEnabled = false
            menuActive = true
        } else {
            self.cosmeticTable.isUserInteractionEnabled = true
            menuActive = false
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSkins),
                                               name: NSNotification.Name("showSkins"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showEmotes),
                                               name: NSNotification.Name("showEmotes"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showGliders),
                                               name: NSNotification.Name("showGliders"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showPickaxe),
                                               name: NSNotification.Name("showPickaxe"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showBackBling),
                                               name: NSNotification.Name("showBackBling"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showContrails),
                                               name: NSNotification.Name("showContrails"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLoadingScreens),
                                               name: NSNotification.Name("showLoadingScreens"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSprays),
                                               name: NSNotification.Name("showSprays"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showAccount),
                                               name: NSNotification.Name("showAccount"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showAbout),
                                               name: NSNotification.Name("showAbout"),
                                               object: nil)
        
    }
    
    
    @objc func getAllCosmetics (cosmetic : String) {
        let query = PFQuery(className: cosmetic)
        query.order(byAscending: "Rarity")
        query.addAscendingOrder("Name")
        query.findObjectsInBackground(block: { (objects, error) in
            if error != nil {
                
            } else if let objects = objects {
                self.cosmeticName.removeAll()
                self.cosmeticImage.removeAll()
                self.cosmeticId.removeAll()
                self.cosmeticRarity.removeAll()
                self.obtained.removeAll()
                for object in objects {
                    self.cosmeticName.append(object["Name"] as! String)
                    self.cosmeticImage.append(object["Image"] as! PFFile)
                    self.cosmeticId.append((object.objectId as String?)!)
                    self.cosmeticRarity.append(object["Rarity"] as! String)
                    self.obtained.append(object["Obtained"] as! String)
                    DispatchQueue.main.async {
                        self.cosmeticTable.reloadData()
                    }
                    
                    if self.cosmeticName.count > 99 {
                        self.getMoreCosmetics(cosmetic: self.cosmeticTracker)
                    }
                }
            }
        })
        
        let query1 = PFQuery(className: (cosmetic + owned))
        query1.whereKey("theUser", equalTo: PFUser.current()?.objectId as Any)
        query1.findObjectsInBackground(block: { (objects, error) in
            if error != nil {
                
            } else if let objects = objects {
                self.cosmeticIdOwned.removeAll()
                for object in objects {
                    self.cosmeticIdOwned.append(object["theCosmetic"] as! String)
                }
            }
        })
    }
    
    
    func getMoreCosmetics(cosmetic: String){
        let query = PFQuery(className: cosmetic)
        query.skip = 100
        query.order(byAscending: "Rarity")
        query.addAscendingOrder("Name")
        query.findObjectsInBackground(block: { (objects, error) in
            
            if error != nil {
                
            } else if let objects = objects {
                
                for object in objects {
                    self.cosmeticName.append(object["Name"] as! String)
                    self.cosmeticImage.append(object["Image"] as! PFFile)
                    self.cosmeticId.append((object.objectId as String?)!)
                    self.cosmeticRarity.append(object["Rarity"] as! String)
                    self.obtained.append(object["Obtained"] as! String)
                    DispatchQueue.main.async {
                        self.cosmeticTable.reloadData()
                    }
                    
                }
            }
        })
    }
    
    
    func getMoreCosmeticsTwo(cosmetic: String){
        let query = PFQuery(className: cosmetic)
        query.skip = 200
        query.order(byAscending: "Rarity")
        query.addAscendingOrder("Name")
        query.findObjectsInBackground(block: { (objects, error) in
            
            if error != nil  {
               
            } else if let objects = objects {
                
                for object in objects {
                    self.cosmeticName.append(object["Name"] as! String)
                    self.cosmeticImage.append(object["Image"] as! PFFile)
                    self.cosmeticId.append((object.objectId as String?)!)
                    self.cosmeticRarity.append(object["Rarity"] as! String)
                    self.obtained.append(object["Obtained"] as! String)
                    DispatchQueue.main.async {
                        self.cosmeticTable.reloadData()
                    }
                    if self.cosmeticName.count > 199 {
                        self.getMoreCosmetics(cosmetic: self.cosmeticTracker)
                    }
                }
            }
        })
    }
    
    
    @objc func getOwnedCosmetics (cosmetic : String){
        
        
        if PFUser.current() != nil {
            let query = PFQuery(className: (cosmetic + owned))
            query.whereKey("theUser", equalTo: PFUser.current()?.objectId as Any)
            query.findObjectsInBackground(block: { (objects, error) in
                if error != nil {
                    
                } else if let objects = objects {
                    self.cosmeticIdOwned.removeAll()
                    for object in objects {
                        self.cosmeticIdOwned.append(object["theCosmetic"] as! String)
                    }
                }
            })
            print (cosmeticIdOwned)
            if cosmeticIdOwned.count > 0 {
                getOwnedCosmeticsQuery()
            }
            else {
                self.displayAlert(title: "No items owned", message: "Add \(cosmeticTracker) to your collection")
                
                seg.selectedSegmentIndex = 0
                
            }
        }
        else {
            self.displayAlert(title: "Unable to retrieve data", message: "Please sign in under account")
            seg.selectedSegmentIndex = 0
            
        }
    }
    
    
    func getOwnedCosmeticsQuery (){
        let queryOwned = PFQuery(className: cosmeticTracker)
        queryOwned.whereKey("objectId", containedIn: cosmeticIdOwned as [AnyObject])
        queryOwned.order(byAscending: "Rarity")
        queryOwned.addAscendingOrder("Name")
        queryOwned.findObjectsInBackground(block: { (objects, error) in
            if error != nil {
                
            } else if let objects = objects {
                self.cosmeticName.removeAll()
                self.cosmeticImage.removeAll()
                self.cosmeticId.removeAll()
                self.cosmeticRarity.removeAll()
                self.obtained.removeAll()
                for object in objects {
                    self.cosmeticName.append(object["Name"] as! String)
                    self.cosmeticImage.append(object["Image"] as! PFFile)
                    self.cosmeticId.append((object.objectId as String?)!)
                    self.cosmeticRarity.append(object["Rarity"] as! String)
                    self.obtained.append(object["Obtained"] as! String)
                    DispatchQueue.main.async {
                        self.cosmeticTable.reloadData()
                    }
                    if self.cosmeticIdOwned.count > 99 {
                        self.getOwnedCosmeticsQueryTwo()
                    }
                }
            }
        })
    }
    
    
    func getOwnedCosmeticsQueryTwo (){
        let queryOwned = PFQuery(className: cosmeticTracker)
        queryOwned.whereKey("objectId", containedIn: cosmeticIdOwned as [AnyObject])
        queryOwned.order(byAscending: "Rarity")
        queryOwned.addAscendingOrder("Name")
        queryOwned.skip = 100
        queryOwned.findObjectsInBackground(block: { (objects, error) in
            if error != nil  {
                
            } else if let objects = objects {
                for object in objects {
                    self.cosmeticName.append(object["Name"] as! String)
                    self.cosmeticImage.append(object["Image"] as! PFFile)
                    self.cosmeticId.append((object.objectId as String?)!)
                    self.cosmeticRarity.append(object["Rarity"] as! String)
                    self.obtained.append(object["Obtained"] as! String)
                    DispatchQueue.main.async {
                        self.cosmeticTable.reloadData()
                    }
                }
            }
        })
    }
    
    
    @objc func showSkins(){
        cosmeticTracker = "Skins"
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        self.cosmeticTable.isUserInteractionEnabled = true
        menuActive = false
    }
    
    @objc func showEmotes(){
        cosmeticTracker = "Emotes"
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        self.cosmeticTable.isUserInteractionEnabled = true
        menuActive = false
    }
    
    @objc  func showGliders(){
        cosmeticTracker = "Gliders"
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        self.cosmeticTable.isUserInteractionEnabled = true
        menuActive = false
    }
    
    @objc  func showPickaxe(){
        cosmeticTracker = "Pickaxe"
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        self.cosmeticTable.isUserInteractionEnabled = true
        menuActive = false
    }
    
    @objc  func showBackBling(){
        cosmeticTracker = "BackBling"
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        self.cosmeticTable.isUserInteractionEnabled = true
        menuActive = false
    }
    
    @objc  func showContrails(){
        cosmeticTracker = "Contrails"
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        self.cosmeticTable.isUserInteractionEnabled = true
        menuActive = false
    }
    
    @objc  func showLoadingScreens(){
        cosmeticTracker = "LoadingScreens"
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        self.cosmeticTable.isUserInteractionEnabled = true
        menuActive = false
    }
    
    @objc  func showSprays(){
        cosmeticTracker = "Sprays"
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        self.cosmeticTable.isUserInteractionEnabled = true
        menuActive = false
    }
    
    @objc  func showAccount(){
        menuActive = false
        seg.selectedSegmentIndex = 0
        getAllCosmetics(cosmetic: cosmeticTracker)
        self.cosmeticTable.isUserInteractionEnabled = true
        if PFUser.current() != nil {
            let main = UIStoryboard(name: "Main", bundle: nil)
            let first = main.instantiateViewController(withIdentifier: "logoutVC")
            self.present(first,animated: true, completion: nil)
        } else {
            let main = UIStoryboard(name: "Main", bundle: nil)
            let first = main.instantiateViewController(withIdentifier: "LoginVC")
            self.present(first,animated: true, completion: nil)
            self.cosmeticTable.isUserInteractionEnabled = true
        }
    }
    
    @objc  func showAbout(){
        seg.selectedSegmentIndex = 0
        let main = UIStoryboard(name: "Main", bundle: nil)
        let first = main.instantiateViewController(withIdentifier: "aboutVC")
        self.present(first,animated: true, completion: nil)
        menuActive = false
    }
    
    

    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cosmeticName.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cosmeticTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CosmeticTableViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cosmeticImage[indexPath.row].getDataInBackground { (data, error) in
            if let imageData = data {
                if let imageToDisplay = UIImage(data: imageData) {
                    cell.cosmeticImageView.image = imageToDisplay
                }
            }
        }
        
        
        let letters = NSCharacterSet.letters
        let range = obtained[indexPath.row].rangeOfCharacter(from: letters)
        if range != nil {
            cell.iconImageView.image = #imageLiteral(resourceName: "battle pass.png") //battle pass png
        }
        else {
            cell.iconImageView.image = #imageLiteral(resourceName: "vbucks.png") //vbucks png
        }
        
        
        cell.obtainedLabel.text = obtained[indexPath.row]
        
        
        cell.nameLabel.text = cosmeticName[indexPath.row]
        switch cosmeticRarity[indexPath.row] {
        case "ALegendary":
            cell.backgroundColor = UIColor.init(red:255/255, green: 117/255, blue: 26/255, alpha: 0.75)
        case "Epic":
            cell.backgroundColor = UIColor.init(red:153/255, green: 51/255, blue: 204/255, alpha: 0.75)
        case "Rare":
            cell.backgroundColor = UIColor.init(red:51/255, green: 153/255, blue: 255/255, alpha: 0.75)
        case "Uncommon":
            cell.backgroundColor = UIColor.init(red:51/255, green: 153/255, blue: 51/255, alpha: 0.75)
        case "aCommon":
            cell.backgroundColor = UIColor.init(red:153/255, green: 153/255, blue: 153/255, alpha: 0.75)
        default:
            break;
        }
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  guard let vc = segue.destination as? ShowCosmeticViewController else { return}
        if segue.identifier == "showCosmeticSegue" {
            if let indexPath = self.cosmeticTable.indexPathForSelectedRow {
                let vc = segue.destination as! ShowCosmeticViewController
                vc.cosmeticImage = [cosmeticImage[indexPath.row]]
                vc.cosmeticName = [cosmeticName[indexPath.row]]
                vc.objectIds = [cosmeticId[indexPath.row]]
                vc.cosmeticRarity = [cosmeticRarity[indexPath.row]]
                vc.cosmeticTracker = cosmeticTracker
            }
        }
    }
    
    
}

