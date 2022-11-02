//
//  SettingsViewController.swift
//  instaCloneFirebaseApplication
//
//  Created by Berkay on 10.10.2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signOutClicked(_ sender: Any) {
        do {
            try
            Auth.auth().signOut()
            performSegue(withIdentifier: "toMainVC", sender: nil)
            } catch {
                print("error")
            }
        }
}
