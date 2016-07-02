//
//  AddItemViewController.swift
//  Checklists
//
//  Created by 洪浩东 on 7/2/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

//我们要做的是让ChecklistViewController遵从AddItemViewController的协议,一下定义协议的方法(注意只有方法)
protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController,didFinishAddItem item: ChecklistItem)
}

class AddItemViewController : UITableViewController,UITextFieldDelegate{
    
    @IBOutlet weak var doneBarButton : UIBarButtonItem!
    @IBOutlet weak var textField : UITextField!
    weak var delegate: AddItemViewControllerDelegate?
    
    @IBAction func cancel(){
//        dismissViewControllerAnimated(true, completion: nil)
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done(){
        
//        dismissViewControllerAnimated(true, completion: nil)
        
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        delegate?.addItemViewController(self, didFinishAddItem: item)
    }
    //not allow to select
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText : NSString = textField.text!
        let newText : NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneBarButton.enabled = (newText.length>0)
        return true
    }
    
    
}
