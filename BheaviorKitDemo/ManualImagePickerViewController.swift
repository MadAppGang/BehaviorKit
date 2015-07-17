//
//  ManualImagePickerViewController.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 10/07/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import UIKit

class ManualImagePickerViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var imagePicker: ImagePickerBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func pickImage(sender: AnyObject) {
        imagePicker.pickImage(self)
    }
    
    @IBAction func imagePicked(picker: ImagePickerBehavior) {
        self.imageView.image = picker.image
    }
    
}
