//
//  ViewController.swift
//  instaCloneFirebaseApplication
//
//  Created by Berkay on 10.10.2022.
//

import UIKit
import FirebaseAuth
 

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextfield.text != "" {
            
            // checking that has user signed up before? 
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextfield.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error") 
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailTextField.text != nil && passwordTextfield.text != nil {
            
            // creating the user with Firestore
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextfield.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "ERror", messageInput: error?.localizedDescription ?? "Error!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }
        
    }
    
    // typical alert message
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

