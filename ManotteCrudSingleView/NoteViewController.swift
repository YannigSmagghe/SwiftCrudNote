//
//  NoteViewController.swift
//  ManotteCrudSingleView
//
//  Created by admin on 04/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class NoteViewController: UITableViewController {

    // Connection à l'app j'obtiens un tableau vide des notes prises
    var notes: [Note] = []
    /*
     [
        ["titre": "Ma note de frais","lieu": "Lyon","image": "/monimage"]
     ]
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let basicNote = Note(titre: "Ma basic note", lieu: "Lyon", image: "Monimage")
        
        notes.append(basicNote)
        
        // Va recréer la data table à la suite de MARK
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.titre
        cell.detailTextLabel?.text = note.lieu
        
        return cell
    }
    //MARK - Navigation
    
    //unwind segue
    // Add new note or edit
    @IBAction func unwindToNoteList(segue: UIStoryboardSegue){
        if let viewController = segue.source as? AddNoteViewController{
            guard let titre:String = viewController.titreTextField.text,let lieu:String = viewController.lieuTextField.text,let image:String = viewController.imageTextField.text else {return}
            let note = Note(titre: titre, lieu: lieu, image: image)
            if let indexPath = viewController.indexPathForNote {
                notes[indexPath.row] = note
            }else{
                 notes.append(note)
            }
            tableView.reloadData()
        }else if let viewController = segue.source as? NoteDetailViewController{
            
            if viewController.isDeleted {
                print(viewController.indexPath)
                print("hi")
                guard let indexPath:IndexPath = viewController.indexPath else{return}
                print("hi")
                notes.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noteDetailSegue"{
            guard let viewController = segue.destination as? NoteDetailViewController else { return }
            // On récupère l'index path de la row selectionné pour voir les détails
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let note = notes[indexPath.row]
            viewController.note = note
            viewController.indexPath = indexPath
        }
    }
    
    
}
