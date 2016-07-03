//
//  ViewController.swift
//  Checklists
//
//  Created by 洪浩东 on 7/1/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit




class ChecklistViewController: UITableViewController,ItemDetailViewControllerDelegate{
    
    var items : [ChecklistItem]
    
//    var delegate: ItemDetailViewControllerDelegate
    
    //the init method is called by Swift when the object comes into existenc
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
            let item = items[indexPath.row]
            
            item.checked = !item.checked
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        saveChecklistItems()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell,withChecklistItem item: ChecklistItem)
    {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "✔︎"
        }
        else {
            label.text = ""
        }
    }
    func configureTextForCell(cell: UITableViewCell,withChecklistItem item:ChecklistItem)
    {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let item = items[indexPath.row]
        
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        
        
        return cell
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        items.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        saveChecklistItems()
    }
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddItem item: ChecklistItem) {
        let newRowIndex = items.count
        
        items.append(item)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
        saveChecklistItems()
    }
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditItem item: ChecklistItem) {
        if let index = items.indexOf(item){
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withChecklistItem: item)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        saveChecklistItems()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            
            //Tell ItemDetailViewController object that ChecklistViewController object is now its delegate
            //self is ChecklistViewController
            controller.delegate = self
            
        }
        else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    /*
     encoding
     **/
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    func dataFilePath() -> String {
         return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
    }
    func saveChecklistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(items, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    /*
     decoding
     **/
    required init?(coder aDecoder: NSCoder)
    {
         // initializer implementation goes here
        items = [ChecklistItem]()  //初始化一个array
        // subclass implementation of the required initializer goes here
        super.init(coder: aDecoder)
        
        loadChecklistItems()
    }
    func loadChecklistItems(){
        //1
        let path = dataFilePath()
        //2
        if NSFileManager.defaultManager().fileExistsAtPath(path)
        {
            //3
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                items = unarchiver.decodeObjectForKey("ChecklistItems") as! [ChecklistItem]
                unarchiver.finishDecoding()
            }
        }
    }
}

