//
//  ImagePickerBehavior.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 09/07/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import UIKit

/// This Behavior shows image picker
/// could be configured to show action sheet and choose source type
/// or open source type directly
/// a lot of properties configutrable, look and properties descriptions
class ImagePickerBehavior: Behavior {
    
    
    /// Result image
    var image: UIImage? = nil
    
//    deinit {
//        print("\(self)")
//    }
    
    /// UIImagePickerControllerCameraCaptureMode
    /// false   = Photo
    /// true    = Video
    @IBInspectable var videoCaptureMode: Bool = false
    
    /// A Boolean value indicating whether the user is allowed to edit a selected still image or movie.
    @IBInspectable var allowEditing: Bool = false
    
    /// Show UIActionSheet with promting about getting image from Camera or Photo Library
    @IBInspectable var askAboutSourceType: Bool = false
    
    /// Setting camera device
    /// UIImagePickerControllerCameraDevice:
    /// false   =  Rear
    /// true    =  Front
    @IBInspectable var useFrontCameraDevice: Bool = false
    
    
    /// TODO: Implement
    //var showCameraControls: Bool = true
    
    ///Source type with numbers UIImagePickerControllerSourceType:
    ///PhotoLibrary     = 0 (and other by default)
    ///Camera           = 1
    ///SavedPhotosAlbum = 2
    ///
    @IBInspectable var sourceType: Int = 0
    
    var imagePickerSourceType: UIImagePickerControllerSourceType {
        get {
            if let st  = UIImagePickerControllerSourceType(rawValue: sourceType) {
                return st
            } else {
                return .PhotoLibrary
            }
        }
        
        set {
            sourceType = newValue.rawValue
        }
    }
    
    
    /// Video quality settings for movies recorded with the built-in camera, or transcoded by displaying in the image picker
    /// UIImagePickerControllerQualityType:
    /// TypeHigh            = 0
    /// TypeMedium          = 1
    /// TypeLow             = 2
    /// Type640x480         = 3
    /// TypeIFrame1280x720  = 4
    /// TypeIFrame960x540   = 5
    @IBInspectable var videoQualityType: Int = 0

    
    /// The flash mode to use with the active camera.
    /// UIImagePickerControllerCameraFlashMode:
    /// Off  = -1
    /// Auto = 0
    /// On   = 1
    @IBInspectable var cameraFlashMode: Int = 0

    /// Image view, that will show the result after picking
    @IBOutlet weak var resultImageView:UIImageView? = nil
    
    /// View controllet to present picker and/or action sheet
    @IBOutlet weak var presentationViewController:UIViewController!
    
    /**
    Pick image or show action sheet to select image/video source
    */
    @IBAction func pickImage(_: AnyObject) {
        if askAboutSourceType == true {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            let cancelAction = UIAlertAction(title: NSLocalizedString("MAGImagePickerBehaviour_CancelButtonTitle", comment: ""), style: .Cancel) {
                action in
                //Do Nothing for cancel
            }
            let photoSourceAction = UIAlertAction(title: NSLocalizedString("MAGImagePickerBehaviour_PhotoSourceButtonTitle", comment: ""), style: .Default) {
                action in
                self.pickImageFromInternalSource(.PhotoLibrary)
            }

            let cameraSourceAction = UIAlertAction(title: NSLocalizedString("MAGImagePickerBehaviour_CameraSourceButtonTitle", comment: ""), style: .Default) {
                action in
                self.pickImageFromInternalSource(.Camera)
            }

            let savedPhototsSourceAction = UIAlertAction(title: NSLocalizedString("MAGImagePickerBehaviour_SavedPhotosAlbumSourceButtonTitle", comment: ""), style: .Default) {
                action in
                self.pickImageFromInternalSource(.SavedPhotosAlbum)
            }
            
            actionSheet.addAction(cancelAction)
            actionSheet.addAction(photoSourceAction)
            actionSheet.addAction(cameraSourceAction)
            actionSheet.addAction(savedPhototsSourceAction)
            
            if let vc = viewController {
                vc.presentViewController(actionSheet, animated: true) {
                    
                }
            }
        } else {
            pickImageFromInternalSource(imagePickerSourceType)
        }
    }
}



// MARK: - Image Picker Controller delegate
extension ImagePickerBehavior: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        image = info[UIImagePickerControllerEditedImage] as? UIImage
        if image == nil {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        if let imageView = resultImageView {
            imageView.image = image
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
        sendActionsForControlEvents(.ValueChanged)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

// MARK: - Private methods
extension ImagePickerBehavior {
    var viewController: UIViewController?  {
        if let viewController = presentationViewController {
            return viewController
        } else if let viewController = UIApplication.sharedApplication().keyWindow?.rootViewController {
            return viewController
        } else {
            assertionFailure("Can't find presentation view controller")
        }
        return nil
    }
    
    func pickImageFromInternalSource(aSourceType: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(aSourceType) {
            pickerController.sourceType = aSourceType
        } else {
            pickerController.sourceType = .PhotoLibrary
        }
        
        if pickerController.sourceType == .Camera {
            pickerController.cameraDevice = (useFrontCameraDevice==true ? .Front : .Rear)
            if let vq = UIImagePickerControllerQualityType(rawValue: videoQualityType) {
                pickerController.videoQuality = vq
            }
            if let cfm = UIImagePickerControllerCameraFlashMode(rawValue: cameraFlashMode) {
                pickerController.cameraFlashMode = cfm
            }
            pickerController.cameraCaptureMode = (videoCaptureMode==true ? .Video : .Photo)
        }
        
        pickerController.allowsEditing = allowEditing
        pickerController.delegate = self
        if let vc = viewController {
            vc.presentViewController(pickerController, animated: true, completion: nil)
        }
    }
}
