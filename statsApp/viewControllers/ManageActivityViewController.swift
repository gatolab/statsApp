//
//  ManageItemViewController.swift
//  statsApp
//
//  Created by Federico Lopez on 23/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit

class ManageActivityViewController: UIViewController {

    var activity: Activity? = nil
    
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        if(self.activity == nil){
            self.title = "New activity"
            self.nameTextField.text = ""
        }
        else {
            self.title = "Edit activity"
            self.nameTextField.text = self.activity?.name
        }
    }

    // MARK: Actions
    @IBAction func saveButtonTap(_ sender: Any) {
        if(!self.nameTextField.text!.isEmpty) {
            if(self.activity == nil) {
                let newActivity = Activity(name: self.nameTextField.text!)
                newActivity.saveToServer(firstTime: true) { (error) in
                    if(error==nil){
                        print("Activity creada")
                        SEND_NOTIFICATION(nUpdateActivities)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                self.activity?.name = self.nameTextField.text!
                self.activity?.saveToServer(callback: { (error) in
                    if(error==nil) {
                        print("Activity editada")
                        SEND_NOTIFICATION(nUpdateActivities)
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
    }
    
    
    
}
