//
//  ManageItemViewController.swift
//  statsApp
//
//  Created by Federico Lopez on 23/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit

class ManageItemViewController: UIViewController {

    var item: Item? = nil
    
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        if(self.item == nil){
            self.title = "New item"
            self.nameTextField.text = ""
        }
        else {
            self.title = "Edit item"
            self.nameTextField.text = self.item?.name
        }
    }

    // MARK: Actions
    @IBAction func saveButtonTap(_ sender: Any) {
        if(!self.nameTextField.text!.isEmpty) {
            if(self.item == nil) {
                let newItem = Item(name: self.nameTextField.text!)
                newItem.saveToServer(firstTime: true) { (error) in
                    if(error==nil){
                        print("item creado!")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                self.item?.name = self.nameTextField.text!
                self.item?.saveToServer(callback: { (error) in
                    if(error==nil) {
                        print("item editado!")
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
    }
    
    
    
}
