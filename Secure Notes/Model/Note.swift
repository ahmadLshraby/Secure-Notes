//
//  Note.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    
     @objc dynamic var message: String = ""
     @objc dynamic var noteTitle: String = ""
    var lockStatus: LockStatus = .unlocked
    
    convenience init(message: String, noteTitle: String, lockStatus: LockStatus) {
        self.init()
        self.message = message
        self.noteTitle = noteTitle
        self.lockStatus = lockStatus
    }
}
