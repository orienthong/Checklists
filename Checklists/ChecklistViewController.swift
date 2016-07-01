//
//  ViewController.swift
//  Checklists
//
//  Created by 洪浩东 on 7/1/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit




class ChecklistViewController: UITableViewController {
    
    var items : [ChecklistItem]
    
    //the init method is called by Swift when the object comes into existenc
    required init?(coder aDecoder: NSCoder)
    {
        items = [ChecklistItem]()  //初始化一个array
        
        let row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ChecklistItem()
        row1item.text = "Walk the dog"
        row1item.checked = false
        items.append(row1item)
        
        let row2item = ChecklistItem()
        row2item.text = "Walk the dog1"
        row2item.checked = true
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Walk the dog2"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Walk the dog3"
        row4item.checked = true
        items.append(row4item)
        
        let row5item = ChecklistItem()
        row5item.text = "Walk the dog4"
        row5item.checked = false
        items.append(row5item)
        
        let row6item = ChecklistItem()
        row6item.text = "Walk the dog5"
        row6item.checked = true
        items.append(row6item)
        
        super.init(coder: aDecoder)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
            let item = items[indexPath.row]
            
            item.checked = !item.checked
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell,withChecklistItem item: ChecklistItem)
    {
        if item.checked {
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
    }
    func configureTextForCell(cell: UITableViewCell,withChecklistItem item:ChecklistItem)
    {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item .text
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


}

