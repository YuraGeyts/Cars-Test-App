//
//  ViewController.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 02.04.2022.
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
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }

    @IBAction func signInAction(_ sender: Any) {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if (login.isEmpty || password.isEmpty) {
            let alert = UIAlertController(title: "Error", message: "Login or password is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true, completion: nil)
        } else {
            LoginManager.userLogin = login
            LoginManager.userPassword = password
            LoginManager.isLogged = true
            
            NotificationCenter.default.post(name: Notification.Name("ReloadView"), object: nil)
            dismiss(animated: true)
        }
    }
}

