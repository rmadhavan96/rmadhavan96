//
//  CreateAccountModel.swift
//  Inzodiac_iOS
//
//  Created by Rohin Madhavan on 22/05/2022.
//

import Foundation

class CreateAccountModel{
    let fullname: String
    let password: String
    let email: String
    let mobile: String
    let gender: String
    let orientation: String
    let interested: String
    let dob: String
    let lookingFor: String
    let termsConditions: Bool
    
    
    init(_fullname: String, _password: String, _email: String,
         _mobile: String, _gender: String, _orientation: String,
         _interested: String, _dob: String, _termsConditions: Bool, _lookingFor: String) {
        self.fullname = _fullname
        self.password = _password
        self.email = _email
        self.mobile = _mobile
        self.gender = _gender
        self.orientation = _orientation
        self.interested = _interested
        self.dob = _dob
        self.termsConditions = _termsConditions
        self.lookingFor = _lookingFor
    }
    
    func validate() -> (String,Bool) {
        if fullname == "" || email == "" || mobile == "" || password == "" || gender == "" || orientation == "" || interested == "" || dob == "" || termsConditions == false || lookingFor == "" {
            return ("All fields Mandatory!", false)
        }
        if !isValidEmail(email: email) {
            return ("Email Address Invalid!", false)
        }
        if !mobile.isPhoneNumber {
            return ("Phone Number Invalid!", false)
        }
        if !validateDateOfBirth() {
            return ("Date of Birth less than 18!", false)
        }
        return ("",true)
    }
    
    func validateDateOfBirth() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.date(from: dob) {
            let age = Calendar.current.dateComponents([.year], from: date, to: Date()).year!
            print(age)
            if age < 18 {
                return false
            }
        }
        return true
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
