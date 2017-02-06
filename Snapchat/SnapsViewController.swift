//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Justin Cook on 2/5/17.
//  Copyright © 2017 Justin Allen Designs. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            print ("Signed Out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        dismiss(animated: true, completion: nil)
    }

}
