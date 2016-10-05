//
//  CatsTable.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 26.08.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import UIKit

let cellIdentifier = "catsCell"

class CatsTable: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var catLists : Results<CatList>!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let catsCellNib = UINib(nibName: "CatsCell", bundle: nil)
        self.tableView.registerNib(catsCellNib, forCellReuseIdentifier: cellIdentifier)
        self.animateTable()
        APIManager.sharedInstance.getCatsList { (cats) in
            if (resultObject != nil){
                
                do {
                        try uiRealm.write {
                        for cat in cats {
                            realm.add(cat, update: true)
                        }
                    }
                } catch let error as NSError {
                    //TODO: Handle error
                }
    
            }
           
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateTable() {
        self.tableView.reloadData()
        
        let cells = self.tableView.visibleCells
        let tableHeight: CGFloat = self.tableView.bounds.size.height
        
        for lCell in cells {
            let cell: UITableViewCell = lCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 4
        
        for lCell in cells {
            let cell: UITableViewCell = lCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    func displayAlertToAddCatList(updatedList:CatList!){
        
        var title = "New Cats List"
        var doneTitle = "Create"
        if updatedList != nil{
            title = "Update Tasks List"
            doneTitle = "Update"
        }
        
        let alertController = UIAlertController(title: title, message: "Write the name of your Cats list", preferredStyle: UIAlertControllerStyle.Alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let listName = alertController.textFields?.first?.text
            
            if updatedList != nil{
                // update mode
                try! uiRealm.write{
                    updatedList.name = listName!
                    self.readTasksAndUpdateUI()
                }
            }
            else{
                let newCatList = CatList()
                newCatList.name = listName!
                
                try! uiRealm.write{
                    
                    uiRealm.add(newCatList)
                    self.readTasksAndUpdateUI()
                }
            }
            
            print(listName)
        }
        
        alertController.addAction(createAction)
        createAction.enabled = false
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Task List Name"
            textField.addTarget(self, action: #selector(CatListsViewController.listNameFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
            if updatedList != nil{
                textField.text = updatedList.name
            }
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func readTasksAndUpdateUI(){
        catLists = uiRealm.objects(CatList)
        self.catListsTableView.setEditing(false, animated: true)
        self.catListsTableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension CatsTable: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catLists.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CatsCell
        
        
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath: NSIndexPath) -> (){
        let listToBeUpdated = self.catsList[indexPath.row]
        self.displayAlertToAddCatsList(listToBeUpdated)
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 15}
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 260
    }
    
}
