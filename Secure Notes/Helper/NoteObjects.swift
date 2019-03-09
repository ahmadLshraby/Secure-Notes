//
//  NoteObjects.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation

// Static Notes
var note1 = Note(message: "Facebook", lockStatus: .locked)
var note2 = Note(message: "Github", lockStatus: .unlocked)
var note3 = Note(message: "LinkedIn", lockStatus: .locked)

var notesArray: [Note] = [note1, note2, note3]
