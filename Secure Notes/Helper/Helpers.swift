//
//  Helpers.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/10/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation

func isNoteLocked(_ lockStatus: LockStatus) -> Bool {
    if lockStatus == .locked {
        return true
    }else {
        return false
    }
}

func lockStatusSwitch(_ lockStatus: Bool) -> Bool {
    if lockStatus == true {
        return false
    }else {
        return true
    }
}
