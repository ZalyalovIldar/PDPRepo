//
//  EditOrAddNewCat.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 05.10.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class EditOrAddNewCat: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedList : CatsList!
    var catsArr : Results<Cat>!
    var currentCreateAction:UIAlertAction!
    
    var isEditingMode = false
    
    @IBOutlet weak var catTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedList.name
        readAndUpateUI()
    }
    
    // MARK: - User Actions -
    
    @IBAction func didClickOnEdit(sender: AnyObject) {
        isEditingMode = !isEditingMode
        self.catTableView.setEditing(isEditingMode, animated: true)
    }
    @IBAction func didClickOnNewCat(sender: AnyObject) {
        self.displayAlertToAddCat(nil)
    }
    func readAndUpateUI(){
        
        catsArr = self.selectedList.cat.filter("id")
        
        self.catTableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource -
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return catsArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        var cat: Cat!
        
        cat = catsArr[indexPath.row]
        
        
        cell?.textLabel?.text = cat.name
        return cell!
    }
    
    
    func displayAlertToAddCat(updatedCat:Cat!){
        
        var title = "New Cat"
        var doneTitle = "Create"
        if updatedCat != nil{
            title = "Update Cat"
            doneTitle = "Update"
        }
        
        let alertController = UIAlertController(title: title, message: "Write the name of your cat", preferredStyle: UIAlertControllerStyle.Alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let catName = alertController.textFields?.first?.text
            
            if updatedCat != nil{
                // update mode
                try! uiRealm.write{
                    updatedCat.name = catName!
                    self.readAndUpateUI()
                }
            }
            else{
                
                let newCat = Cat()
                newCat.name = catName!
                
                try! uiRealm.write{
                    
                    self.selectedList.cats.append(newCat)
                    self.readAndUpateUI()
                }
            }
            
            print(catName)
        }
        
        alertController.addAction(createAction)
        createAction.enabled = false
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Cat Name"
            textField.addTarget(self, action: #selector(EditOrAddNewCat.catNameFieldDidChange(_:)) , forControlEvents: UIControlEvents.EditingChanged)
            if updatedCat != nil{
                textField.text = updatedCat.name
            }
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func catNameFieldDidChange(textField:UITextField){
        self.currentCreateAction.enabled = textField.text?.characters.count > 0
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            //Deletation
            var catToBeDeleted: Cat!
            
             catToBeDeleted = self.catsArr[indexPath.row]
            
            try! uiRealm.write{
                uiRealm.delete(catToBeDeleted)
                self.readAndUpateUI()
            }
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in
            
            // Editing will go here
            var catToBeUpdated: Cat!
            if indexPath.section == 0{
                catToBeUpdated = self.catsArr[indexPath.row]
            }
            else{
                catToBeUpdated = self.completedCats[indexPath.row]
            }
            
            self.displayAlertToAddCats(catToBeUpdated)
            
        }
        
        let doneAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Done") { (doneAction, indexPath) -> Void in
            // Editing will go here
            var catToBeUpdated: Cat!
            if indexPath.section == 0{
                catToBeUpdated = self.catsArr[indexPath.row]
            }
            else{
                catToBeUpdated = self.catsArr[indexPath.row]
            }
            try! uiRealm.write{
                catsToBeUpdated.isCompleted = true
                self.readAndUpateUI()
            }
            
        }
        return [deleteAction, editAction, doneAction]
    }
    
    
}
