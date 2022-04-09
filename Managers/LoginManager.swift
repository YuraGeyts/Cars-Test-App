//
//  LoginManager.swift
//  Cars Test App
//
//  Created by Юра Гейц on 02.04.2022.
//

import Foundation
import UIKit

class LoginManager {
    
    private enum LoginKeys: String {
        case userLogin
        case userPassword
        case isLogged
    }
    
    static var userLogin: String! {
        get {
            print("Getting userLogin")
            let userLogin = UserDefaults.standard.string(forKey: LoginKeys.userLogin.rawValue)
            print("UserLogin == \(String(describing: userLogin))")
            return userLogin
        } set {
            let defaults = UserDefaults.standard
            let key = LoginKeys.userLogin.rawValue
            if let login = newValue {
                if login != "" {
                    print("Login not empty, we are saving login")
                    defaults.set(login, forKey: key)
                    print("\(login) is saved")
                } else {
                    print("Login is empty -> remove login")
                    defaults.removeObject(forKey: key)
                }
            }
        }
    }
    
    static var userPassword: String! {
        get {
            return UserDefaults.standard.string(forKey: LoginKeys.userPassword.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = LoginKeys.userPassword.rawValue
            if let password = newValue {
                if password != "" {
                    defaults.set(password, forKey: key)
                } else {
                    defaults.removeObject(forKey: key)
                }
            }
        }
    }
    
    static var isLogged: Bool! {
        get {
            return UserDefaults.standard.bool(forKey: LoginKeys.isLogged.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = LoginKeys.isLogged.rawValue
            if let isLogged = newValue {
                if isLogged {
                defaults.set(isLogged, forKey: key)
                } else {
                    defaults.removeObject(forKey: key)
                }
            }
        }
    }
    
    
    static func checkLogin(vc: UIViewController) {
        if self.userLogin == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "loginView")
            vc.present(viewController, animated: true, completion: nil)
        }
    }
    
    static func login(vc: UIViewController) {
        //starting viewController
    }
    
    static func logOut() {
        let defaults = UserDefaults.standard
        let loginKey = LoginKeys.userLogin.rawValue
        let passwordKey = LoginKeys.userPassword.rawValue
        let isLoggedKey = LoginKeys.isLogged.rawValue
        defaults.removeObject(forKey: loginKey)
        defaults.removeObject(forKey: passwordKey)
        defaults.removeObject(forKey: isLoggedKey)
    }
}
