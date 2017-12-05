//
//  AddNoteViewController.swift
//  ManotteCrudSingleView
//
//  Created by admin on 04/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    var panelTitleText = "Nouvelle Note de frais"
    var note: Note? = nil
    var indexPathForNote: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panelTitleLabel.text = panelTitleText
        if let note = note{
            titreTextField.text = note.titre
            lieuTextField.text = note.lieu
            imageTextField.text = note.image
        }
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
