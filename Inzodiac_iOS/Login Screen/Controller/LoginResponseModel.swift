//
//  LoginResponseModel.swift
//  Inzodiac_iOS
//
//  Created by Rohin Madhavan on 24/05/2022.
//

import Foundation

struct LoginResponseModel: Codable {
    var email: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
    }
}
