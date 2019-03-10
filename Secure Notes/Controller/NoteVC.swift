//
//  ViewController.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import RealmSwift
import LocalAuthentication

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
        tableView.reloadData()
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
    
    // MARK: Authentication with Touch ID or Face ID
    func authenticateBiometrics(completion: @escaping (_ success: Bool) -> Void) {
        let myContext = LAContext()  // to be able to use touch id or face id depending on the device automatically
        let myLocalizedReasonString = "Secure Notes uses Touch ID / Face ID ."
        var authError: NSError?
        
        // must iOS > 8.0, check the we have OS support touch id
        if #available(iOS 8.0, macOS 10.12.1, *) {
            // to check if the device uses touch id or face id or not
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { (success, evaluateError) in
                    if success {
                        completion(true)
                    }else {
                        guard let evaluateErrorString = evaluateError?.localizedDescription else { return }
                        // present alert for error
                        self.showAlert(withMessage: evaluateErrorString)
                        completion(false)
                    }
                }
            }else {
                guard let authErrorString = authError?.localizedDescription else { return }
                showAlert(withMessage: authErrorString)
                completion(false)
            }
        }else {
            completion(false)
        }
        }

    
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
        if notes?[indexPath.row].isLocked == true {
            authenticateBiometrics { (success) in
                if success {
                    DispatchQueue.main.async {  // as authentication process is in another thread so return to main thread
                        self.pushNote(indexPath: indexPath)
                    }
                }
            }
            
        }else {
            self.pushNote(indexPath: indexPath)
        }
    }
    func pushNote(indexPath: IndexPath) {
        guard let noteDetailVC = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC else { return }
        noteDetailVC.note = notes?[indexPath.row]
        noteDetailVC.index = indexPath.row
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    

}


