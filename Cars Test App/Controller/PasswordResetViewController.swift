//
//  PasswordResetViewController.swift
//  Cars Test App
//
//  Created by Юра Гейц on 18.04.2022.
//

import UIKit
import Firebase

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func resetPasswordAction(_ sender: Any) {
        let email = emailTextField.text!
        if(!email.isEmpty) {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error == nil {
                    self.dismiss(animated: true)
                }
            }
        }
    }
}
