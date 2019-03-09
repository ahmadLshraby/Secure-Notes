//
//  ViewController.swift
//  Secure Notes
//
//  Created by sHiKoOo on 3/9/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import RealmSwift

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
        loadNotes()
    }

    func loadNotes() {
        notes = realm.objects(Note.self)
        tableView.reloadData()
    }
    
    
    
    
}


extension NoteVC: UITableViewDelegate, UITableViewDataSource {
    
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
    
    
}


