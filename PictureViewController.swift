//
//  PictureViewController.swift
//  Snapchat
//
//  Created by Justin Cook on 2/5/17.
//  Copyright © 2017 Justin Allen Designs. All rights reserved.
//

import UIKit
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var uuid = NSUUID().uuidString

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        nextButton.isEnabled = false
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        imageView.backgroundColor = UIColor.clear
        
        nextButton.isEnabled = true
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        nextButton.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil) { (metadata, error) in
            print("We tried to upload")
            if error != nil {
                print("We had an error:\(error)")
            } else {
                print(metadata?.downloadURL() as Any)
                
               self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)
                print("Image Uploaded Successfully")
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionTextField.text!
        nextVC.uuid = uuid
    }
}
