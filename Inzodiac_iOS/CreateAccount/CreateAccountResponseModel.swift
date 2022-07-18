//
//  CreateAccountResponseModel.swift
//  Inzodiac_iOS
//
//  Created by Rohin Madhavan on 13/06/2022.
//

import Foundation

struct CreateAccountResponseModel: Codable {
    
    var email: String
    var password: String
    var fullName: String
    var gender: String
    var dateOfBirth: String
    var orientation: String
    var InterestedIn: String
    var lookingFor: String
    var mobile: String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
        case fullName = "fullname"
        case gender = "gender"
        case dateOfBirth = "dob"
        case orientation = "orientation"
        case InterestedIn = "interested"
        case lookingFor = "looking_for"
        case mobile = "mobile"
    }
}
