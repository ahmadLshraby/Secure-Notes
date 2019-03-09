//
//  ViewController.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import RealmSwift

class NoteVC: UIViewController {
    
    let realm = try! Realm()
    
    var notes: Results<Note>?

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNotes()
    }

    func loadNotes() {
        notes = realm.objects(Note.self)
        if notes?.count != 0 {
            tableView.isHidden = false
        }else {
            tableView.isHidden = true
        }
        tableView.reloadData()
    }
    
    func delete(indexPath: IndexPath) {
        if let deletedNote = notes?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(deletedNote)
                }
            }catch {
                print("delete error: \(error)")
            }
        }else {
            return
        }
    }
    
    
    
    
}


extension NoteVC: UITableViewDelegate, UITableViewDataSource {
    // TableView configuration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteCell {
            guard let note = notes?[indexPath.row] else { return NoteCell()}
            cell.configureCell(note: note)
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
//    // Swipe to Delete
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .none
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "🗑 \n DELETE") { (rowAction, indexPath) in
            self.delete(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)  // delete the row of that indexPath
            self.loadNotes()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Pass the note and present VC (note, indexPath)
        pushNote(indexPath: indexPath)
    }
    func pushNote(indexPath: IndexPath) {
        guard let noteDetailVC = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC else { return }
        noteDetailVC.note = notes?[indexPath.row]
        noteDetailVC.index = indexPath.row
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    

}


