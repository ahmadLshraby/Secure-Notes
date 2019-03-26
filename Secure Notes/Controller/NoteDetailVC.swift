//
//  NoteDetailVC.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import RealmSwift

let realmObj = try! Realm()

class NoteDetailVC: UIViewController {

    @IBOutlet weak var noteMessageTxt: UITextView!
    @IBOutlet weak var btnView: UIView!
    
    var note: Note!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteMessageTxt.text = note?.message
    //    btnView.bindToKeyboard()
    }
    
    @IBAction func lockNoteBtn(_ sender: UIButton) {
        
        do {
            try realmObj.write {
                note?.isLocked = true
                note.message = noteMessageTxt.text
            }
        }catch {
            print("update error: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    


}
