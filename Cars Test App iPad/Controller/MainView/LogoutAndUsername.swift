//
//  LogoutZoneExtension.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 08.04.2022.
//

import Foundation
import UIKit

extension MainViewController {
    
    //Logout
    @IBAction func logOut() {
        stopTimer()
        timerLabel.text = ""
        LoginManager.logOut()
        LoginManager.checkLogin(vc: self)
    }
    
    //UserName
    func getAndShowUserLogin() {
        DispatchQueue.main.async {
            guard let userLogin = LoginManager.userLogin else { return }
            print("try to print userLogin \(userLogin)")
            self.userNameLabel.text = "Hello, \(userLogin)"
        }
    }
}
