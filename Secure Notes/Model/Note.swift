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
     @objc dynamic var isLocked: Bool = false
    
    convenience init(message: String, noteTitle: String, isLocked: Bool) {
        self.init()
        self.message = message
        self.noteTitle = noteTitle
        self.isLocked = isLocked
    }
}
