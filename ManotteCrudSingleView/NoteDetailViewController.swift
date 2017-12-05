//
//  NoteDetailViewController.swift
//  ManotteCrudSingleView
//
//  Created by admin on 04/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import CoreData

class NoteDetailViewController: UIViewController{

    var note: NSManagedObject? = nil
    var isDeleted: Bool = false
    var indexPath: IndexPath? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        titreLabel.text = note?.value(forKey: "titre") as? String
        lieuLabel.text = note?.value(forKey: "lieu") as? String
        imageLabel.text = note?.value(forKey: "image") as? String

        // Do any additional setup after loading the view.
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var titreLabel: UILabel!
    
    @IBOutlet weak var lieuLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UILabel!
    
    @IBAction func doneDetail(_ sender: Any) {
        performSegue(withIdentifier: "unwindToNoteList", sender: self)
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        
        isDeleted = true
        
        performSegue(withIdentifier: "unwindToNoteList", sender: self)

    }
    
    // MARK - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNoteSegue" {
            guard let viewController = segue.destination as?
                AddNoteViewController else{return}
            viewController.panelTitleText = "Éditer une note"
            viewController.note = note
            viewController.indexPathForNote = self.indexPath!
            
        }
    }
}
    
