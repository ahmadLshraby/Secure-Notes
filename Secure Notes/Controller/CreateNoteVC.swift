//
//  CreateNoteVC.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import RealmSwift

 let realm = try! Realm()

class CreateNoteVC: UIViewController {


    @IBOutlet weak var noteTitleTxt: UITextField!
    @IBOutlet weak var noteTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func CreateNoteBtn(_ sender: UIButton) {
        
        guard let noteTitle = noteTitleTxt.text else { return }
        guard let noteMessage = noteTxt.text else { return }
        
        let newNote = Note()
        newNote.noteTitle = noteTitle
        newNote.message = noteMessage
        newNote.lockStatus = .unlocked
        
        save(note: newNote)
        navigationController?.popViewController(animated: true)
    }
    
    
    func save(note: Note) {
        do {
            try realm.write {
                realm.add(note)
            }
        }catch {
            print("save error: \(error)")
        }
    }
    

}
