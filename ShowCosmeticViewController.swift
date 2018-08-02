//
//  ShowCosmeticViewController.swift
//  FortniteCollection
//
//  Created by Austin Dotto on 7/26/18.
//  Copyright © 2018 Austin Dotto. All rights reserved.
//

import UIKit
import Parse

class ShowCosmeticViewController: UIViewController {
    
    
    
    
    var cosmeticImage = [PFFile]()
    var cosmeticName = [""]
    var cosmeticRarity = [""]
    var objectIds = [""]
    var isCollected = false
    var cosmeticTracker = ""
    var owned = "Owned"
    @IBOutlet weak var cosmeticImageView: UIImageView!
    
    @IBAction func collectionButton(_ sender: Any) {
        if PFUser.current() != nil {
            if isCollected == true {
                let query = PFQuery(className: (cosmeticTracker + owned))
                
                query.whereKey("theUser", equalTo: PFUser.current()?.objectId)
                query.whereKey("theCosmetic", equalTo: objectIds[0])
                query.findObjectsInBackground(block: { (objects, error) in
                    if let objects = objects {
                        for object in objects {
                            object.deleteInBackground()
                        }
                    }
                })
                self.displayAlert(title: "", message: "\(cosmeticName[0]) has been removed from your collection" )
                collectionButtonOutlet.setTitle("Add to Collection", for: UIControlState.normal)
                isCollected = false
            } else if isCollected == false {
                
                
                
                let cosmetic = PFObject(className: (cosmeticTracker + owned))
                cosmetic.setObject(PFUser.current()?.objectId, forKey: "theUser")
                cosmetic.setObject(objectIds[0], forKey: "theCosmetic")
                //   cosmetic["theUser"] = PFUser.current()?.objectId
                
                //   cosmetic["theCosmetic"] = objectIds[0]
                
                cosmetic.saveInBackground()
                self.displayAlert(title: "\(cosmeticName[0]) has been added to your collection", message: "" )
                collectionButtonOutlet.setTitle("Remove from collection", for: UIControlState.normal)
                isCollected = true
            }
            
        }
        else {
            self.displayAlert(title: "Sign in to add to collection", message: "")
        }
    }
    @IBOutlet weak var collectionButtonOutlet: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        cosmeticImage[0].getDataInBackground { (data, error) in
            if let imageData = data {
                
                if let imageToDisplay = UIImage(data: imageData) {
                    
                    self.cosmeticImageView.image = imageToDisplay
                    
                }
            }
        }
        navigationItem.title = cosmeticName[0]
        nameLabel.text = cosmeticName[0]
        
        
        switch cosmeticRarity[0] {
        case "ALegendary":
            view.backgroundColor = UIColor.init(red:255/255, green: 117/255, blue: 26/255, alpha: 0.75)
        case "Epic":
            view.backgroundColor = UIColor.init(red:153/255, green: 51/255, blue: 204/255, alpha: 0.75)
        case "Rare":
            view.backgroundColor = UIColor.init(red:51/255, green: 153/255, blue: 255/255, alpha: 0.75)
        case "Uncommon":
            view.backgroundColor = UIColor.init(red:51/255, green: 153/255, blue: 51/255, alpha: 0.75)
        case "aCommon":
            view.backgroundColor = UIColor.init(red:153/255, green: 153/255, blue: 153/255, alpha: 0.75)
        default:
            break;
        }
        
        
        
        let query = PFQuery(className: (cosmeticTracker + owned))
        query.whereKey("theUser", equalTo: PFUser.current()?.objectId)
        query.whereKey("theCosmetic", equalTo: objectIds[0])
        query.findObjectsInBackground(block: { (objects, error) in
            if error != nil { // if they dont
                self.isCollected = false
                self.collectionButtonOutlet.alpha = 1
            } else if let objects = objects {
                self.collectionButtonOutlet.alpha = 1
                //if they do
                for _ in objects {
                    self.isCollected = true
                    self.collectionButtonOutlet.setTitle("Remove from collection", for: UIControlState.normal)
                    
                }
            }
        }
        )
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
