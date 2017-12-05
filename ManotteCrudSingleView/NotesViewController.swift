//
//  NoteViewController.swift
//  ManotteCrudSingleView
//
//  Created by admin on 04/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UITableViewController {
    
    // Connection à l'app j'obtiens un tableau vide des notes prises
    var notes: [NSManagedObject] = []
    /*
     [
     ["titre": "Ma note de frais","lieu": "Lyon","image": "/monimage"]
     ]
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        tableView.reloadData()
        /*
        let basicNote = Note(titre: "Ma basic note", lieu: "Lyon", image: "Monimage")
        
        notes.append(basicNote)
        
        // Va recréer la data table à la suite de MARK
        tableView.reloadData()
         */
        
    }
    
    //MARK: - Data Source
    
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Note")
        do {
            notes = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
    
    func save(titre: String, lieu: String,image:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName:"Note", in: managedObjectContext) else { return }
        let note = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        note.setValue(titre, forKey: "titre")
        note.setValue(lieu, forKey: "lieu")
        note.setValue(image, forKey: "image")
        do {
            try managedObjectContext.save()
            self.notes.append(note)
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }
    
    func update(indexPath: IndexPath, titre:String, lieu: String,image: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let note = notes[indexPath.row]
        note.setValue(titre, forKey: "titre")
        note.setValue(lieu, forKey: "lieu")
        note.setValue(image, forKey: "image")
        do {
            try managedObjectContext.save()
            notes[indexPath.row] = note
        } catch let error as NSError {
            print("Couldn't update. \(error)")
        }
    }
    
    func delete(_ note: NSManagedObject, at indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.delete(note)
        notes.remove(at: indexPath.row)
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
    
    // Main table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.value(forKey:"titre") as? String
        cell.detailTextLabel?.text = note.value(forKey:"lieu") as? String
        
        return cell
    }
    
    //MARK - Navigation
    
    //unwind segue
    // Add new note or edit
    @IBAction func unwindToNoteList(segue: UIStoryboardSegue) {
        print("unwind")
        if let viewController = segue.source as? AddNoteViewController {
            print("from addNote")
            guard let titre: String = viewController.titreTextField.text, let lieu: String = viewController.lieuTextField.text , let image: String = viewController.imageTextField.text else { return }
            if titre != "" && lieu != "" && image != ""{
                 print("non vide")
                if let indexPath = viewController.indexPathForNote {
                    print("update")
                    update(indexPath: indexPath, titre: titre, lieu: lieu,image: image)
                } else {
                    print("create")
                    save(titre: titre, lieu: lieu,image: image)
                }
            }
            tableView.reloadData()
        } else if let viewController = segue.source as? NoteDetailViewController {
            if viewController.isDeleted {
                guard let indexPath: IndexPath = viewController.indexPath else { return }
                let note = notes[indexPath.row]
                print("delete")
                delete(note, at: indexPath)
                tableView.reloadData()
            }
        }
    }
    
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noteDetailSegue"{
            guard let navViewController = segue.destination as? UINavigationController else { return }
            guard let viewController = navViewController.topViewController as? NoteDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let note = notes[indexPath.row]
            viewController.note = note
            viewController.indexPath = indexPath

        }
    }
    
}
