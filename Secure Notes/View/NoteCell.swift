//
//  NoteCell.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(note: Note) {
        titleLbl.text = note.noteTitle
        if note.isLocked == true {
            lockImageView.isHidden = false
        }else {
            lockImageView.isHidden = true
        }
    }
    
    
    
    
}
