//
//  AddNoteViewController.swift
//  ManotteCrudSingleView
//
//  Created by admin on 04/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var panelTitleText = "Nouvelle Note de frais"
    var note: NSManagedObject? = nil
    var indexPathForNote: IndexPath? = nil
    
    var picker:UIImagePickerController?=UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panelTitleLabel.text = panelTitleText
        if let note = self.note{
            titreTextField.text = note.value(forKey: "titre") as? String
            lieuTextField.text = note.value(forKey: "lieu") as? String
            imageTextField.text = note.value(forKey: "image") as? String
        }
        picker?.delegate=self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var panelTitleLabel: UILabel!
    
    @IBOutlet weak var titreTextField: UITextField!
    
    @IBOutlet weak var lieuTextField: UITextField!
    
    @IBOutlet weak var imageTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func OpenGallery(_ sender: UIBarButtonItem) {
        print("Open Gallery")
        openGallary()
    }
    
    @IBAction func TakePhoto(_ sender: Any) {
        print("Take a photo")
        openCamera()
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Close Gallery")
        dismiss(animated: true, completion: nil)
    }
    
    func openGallary()
    {
        print("Open Gallery func")
        picker?.allowsEditing = false
        picker?.sourceType = .photoLibrary
        picker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker!, animated: true, completion: nil)
    }

    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerControllerSourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
        
    
    // MARK: - Navigation
    
    @IBAction func saveAndClose(_ sender: Any) {
        performSegue(withIdentifier: "unwindToNoteList", sender: self)
        
    }
    
    @IBAction func close(_ sender: Any) {
        titreTextField.text = nil
        lieuTextField.text = nil
        imageTextField.text = nil
        performSegue(withIdentifier: "unwindToNoteList", sender: self)
    }
}
