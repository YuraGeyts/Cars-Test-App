//
//  ViewController.swift
//  Cars Test App
//
//  Created by Юра Гейц on 01.04.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardDismiss))
        
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func signIn(_ sender: Any) {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if (login.isEmpty || password.isEmpty) {
            print("Login or password is empty")
            let alert = UIAlertController(title: "Error", message: "Login or password is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        } else {
            //save username and password to memory
            LoginManager.userLogin = login
            LoginManager.userPassword = password
            NotificationCenter.default.post(name: Notification.Name("ReloadView"), object: nil)
            dismiss(animated: true)
        }
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
}

