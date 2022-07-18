//
//  LoginModel.swift
//  Inzodiac_iOS
//
//  Created by Rohin Madhavan on 22/05/2022.
//

import Foundation


class LoginModel{
    let username: String
    let password: String
    
    init(_username: String, _password: String) {
        self.username = _username
        self.password = _password
    }
    
    func validate() -> (String, Bool) {
        if username == "" || password == "" {
            return ("enter username and password", false)
        }
        return ("", true)
    }
}
