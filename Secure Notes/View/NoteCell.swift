//
//  NoteCell.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configureCell(note: Note) {
        if note.lockStatus == .locked {
            messageLbl.text = "This Note is Locked, Unlock to read"
            lockImageView.isHidden = false
        }else {
            messageLbl.text = note.noteTitle
            lockImageView.isHidden = true
        }
    }
    
    
    
    
}
