//
//  ViewController.swift
//  Inzodiac_iOS
//
//  Created by Rohin Madhavan on 26/02/2022.
//

import UIKit

class SplashViewController: BaseViewController {

    @IBOutlet weak var topViewHightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topViewHightConstraint.constant = UIScreen.main.bounds.height / 2
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let registerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

