//
//  MainTableController.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 26.08.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation
import UIKit

class MainTableController: UITableViewController {
    var objectsArr:Array<String>?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.objectsArr = ["Realm + Alamofire"]
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let objectsCount = self.objectsArr?.count else {return 0}
        return objectsCount ;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        guard let object = self.objectsArr?[indexPath.row] else {fatalError()}
        cell.textLabel?.text = object
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            self.performSegueWithIdentifier("realm", sender: nil)
        }
    }
}