//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by 洪浩东 on 7/2/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

//我们要做的是让ChecklistViewController遵从ItemDetailViewController的协议,一下定义协议的方法(注意只有方法)
protocol ItemDetailViewControllerDelegate : class {
    func itemDetailViewControllerDidCancel(controller:ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController,didFinishAddItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController,
        didFinishEditItem itme: ChecklistItem)
}

class ItemDetailViewController : UITableViewController,UITextFieldDelegate{
    
    @IBOutlet weak var doneBarButton : UIBarButtonItem!
    @IBOutlet weak var textField : UITextField!
    weak var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit : ChecklistItem?
    @IBAction func cancel(){
//        dismissViewControllerAnimated(true, completion: nil)
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(){
        
        if let item = itemToEdit { //when is not nil
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditItem: item)
        }
        
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        delegate?.itemDetailViewController(self, didFinishAddItem: item)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let item = itemToEdit{
            title = "Edit Item"
            textField.text = title
            doneBarButton.enabled = true
        }
    }
    
    
}
