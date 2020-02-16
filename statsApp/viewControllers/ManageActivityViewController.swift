//
//  ManageItemViewController.swift
//  statsApp
//
//  Created by Federico Lopez on 23/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit
import CropViewController
import SDWebImage


class ManageActivityViewController: UIViewController, CropViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var activity: Activity? = nil
    var imageWasChanged = false
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var actImageView: UIImageView!
    
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actImageView.image = nil
        if(self.activity == nil){
            self.title = "New activity"
            self.nameTextField.text = ""
        }
        else {
            self.title = "Edit activity"
            self.nameTextField.text = self.activity?.name

            if let _image = SDImageCache.shared().imageFromCache(forKey: activity?.imageURL) {
                self.actImageView.image = _image
                self.actImageView.setCircular()
            }
        }
    }

    // MARK: Actions
    @IBAction func saveButtonTap(_ sender: Any) {
        if(!self.nameTextField.text!.isEmpty) {
            if(self.activity == nil) { //new
                let newActivity = Activity(name: self.nameTextField.text!)
                newActivity.saveToServer(firstTime: true) { (error) in
                    if(error==nil) {
                        if(self.imageWasChanged && self.actImageView.image != nil) {
                            newActivity.uploadImage(image: self.actImageView.image!, callback: { (error) in
                                print("Activity creada")
                                self.finishSave()
                            })
                        } else {
                            print("Activity creada")
                            self.finishSave()
                        }
                    }
                }
            } else { // edit
                self.activity?.name = self.nameTextField.text!
                self.activity?.saveToServer(callback: { (error) in
                    if(error==nil) {
                        if(self.imageWasChanged && self.actImageView.image != nil) {
                            self.activity?.uploadImage(image: self.actImageView.image!, callback: { (error) in
                                print("Activity editada")
                                self.finishSave()
                            })
                        } else {
                            print("Activity editada")
                            self.finishSave()
                        }
                    }
                })
            }
        }
    }
    private func finishSave() {
        SEND_NOTIFICATION(nUpdateActivities)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeImageTap(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            let picker = UIImagePickerController()
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true)
        } else {
            //!!!
        }
    }
    
    func presentCropViewController(image: UIImage) {
        let cropViewController = CropViewController(croppingStyle: .circular, image: image)
        cropViewController.title = "Activity image"
        cropViewController.delegate = self
        self.present(cropViewController, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: false, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.presentCropViewController(image: image)
    }
    
    // MARK: - CropViewController
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage,
                            withRect cropRect: CGRect, angle: Int) {
        self.dismiss(animated: true, completion: nil)
        
        self.actImageView.image = image
        self.actImageView.setCircular()
        self.imageWasChanged = true
    }
    
    
}
