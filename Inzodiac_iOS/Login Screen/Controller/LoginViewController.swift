//
//  LoginViewController.swift
//  Inzodiac_iOS
//
//  Created by Rohin Madhavan on 09/03/2022.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    var loginNetworkManager = LoginNetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signinButtonPressed(_ sender: UIButton) {
        let loginDetails = LoginModel(_username: usernameTextfield.text ?? "", _password: passwordTextfield.text ?? "")
        let validate = loginDetails.validate()
        if validate.1 {
            let loginDetailsResponseModel = LoginResponseModel(email: loginDetails.username, password: loginDetails.password)
            loginNetworkManager.postLoginDetails(loginResponseModel: loginDetailsResponseModel)
        } else {
            print("enter details")
        }
    }

    @IBAction func signinWithGooglePressed(_ sender: UIButton) {
    }
    
    @IBAction func signinWithPhonePressed(_ sender: UIButton) {
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
    }
}
