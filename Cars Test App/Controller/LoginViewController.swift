//
//  ViewController.swift
//  Cars Test App
//
//  Created by Юра Гейц on 01.04.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    var register: Bool = false {
        willSet {
            if newValue {
                welcomeLabel.text = "Register"
                usernameTextField.isHidden = false
                signInButton.setTitle("COMPLETE", for: .normal)
                signUpButton.setTitle("SIGN IN", for: .normal)
            } else {
                welcomeLabel.text = "WELCOME!"
                usernameTextField.isHidden = true
                signInButton.setTitle("SIGN IN", for: .normal)
                signUpButton.setTitle("SIGN UP", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardDismiss))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @IBAction func signIn(_ sender: Any) {
        checkAndGo()
    }
    
    @IBAction func signUp(_ sender: Any) {
        register = !register
    }
    
    func checkAndGo() {
        let username = usernameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if register {
            if (!username.isEmpty && !email.isEmpty && !password.isEmpty) {
                register(login: username, email: email, password: password)
            } else {
                //enter text in textfield
                if username.isEmpty { usernameTextField.select(self) }
                if email.isEmpty { emailTextField.select(self) }
                if password.isEmpty { passwordTextField.select(self) }
            }
        } else {
            if (!email.isEmpty && !password.isEmpty) {
                login(email: email, password: password)
            } else {
                if username.isEmpty { usernameTextField.select(self) }
                if password.isEmpty { passwordTextField.select(self) }
            }
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil {
                self.dismiss(animated: true)
            } else {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .wrongPassword :
                        self.showAlert(message: "Wrong password")
                    case .invalidEmail:
                        self.showAlert(message: "Invalid email")
                    case .userNotFound:
                        print("USER NOT FOUND")
                    @unknown default:
                        print("Some default error")
                    }
                }
            }
        }
        
    }
    
    func register(login: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                if let result = result {
                    print(result.user.uid)
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["login" : login, "email" : email])
                    self.dismiss(animated: true)
                }
            } else {
                print("Register error: \(error)")
            }
        }
    }
    
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        checkAndGo()
        
        return true
    }
}

