//
//  NoteDetailVC.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class NoteDetailVC: UIViewController {

    @IBOutlet weak var noteMessageTxt: UITextView!
    
    var note: Note!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteMessageTxt.text = note?.message
    }
    
    @IBAction func lockNoteBtn(_ sender: UIButton) {
        note?.lockStatus = .locked
        navigationController?.popViewController(animated: true)
    }
    


}
