//
//  CreateAccountViewController.swift
//  Inzodiac_iOS
//
//  Created by Rohin Madhavan on 11/04/2022.
//

import UIKit
import iOSDropDown

class CreateAccountViewController: BaseViewController, NetworkManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var orientationDropDown: DropDown!
    @IBOutlet var genderButton: [UIButton]!
    @IBOutlet var interestedButton: [UIButton]!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var termsAndConditionButton: UIButton!
    @IBOutlet weak var termsAndConditionsImage: UIImageView!
    @IBOutlet weak var lookingForDropDown: DropDown!
    @IBOutlet weak var interestedDropDown: DropDown!
    @IBOutlet weak var genderDropDown: DropDown!
    
    var selectedGender: String?
    var selectedInterest: String?
    let datePicker:UIDatePicker = UIDatePicker()
    var termsAndConditions = false
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        for type in FetchType.allValues {
            networkManager.fetchCreateAccountData(type: type)
        }
        dateOfBirthTextField.delegate = self
        setupUI()
    }
    
    @IBAction func genderButtonPressed(_ sender: UIButton) {
        self.selectedGender = sender.titleLabel?.text
        self.setupButton(button: self.genderButton)
        sender.backgroundColor = UIColor(red: 35/255, green: 15/255, blue: 100/255, alpha: 1.0)
        let attributedString = NSAttributedString(string: selectedGender ?? "",
                                                  attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        sender.setAttributedTitle(attributedString, for: .normal)
        
    }
    
    @IBAction func interestedInButtonPressed(_ sender: UIButton) {
        self.selectedInterest = sender.titleLabel?.text
        self.setupButton(button: self.interestedButton)
        sender.backgroundColor = UIColor(red: 35/255, green: 15/255, blue: 100/255, alpha: 1.0)
        let attributedString = NSAttributedString(string: selectedInterest ?? "",
                                                  attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        sender.setAttributedTitle(attributedString, for: .normal)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let registrationModel = CreateAccountModel(_fullname: nameTextField.text ?? "", _password: passwordTextField.text ?? "", _email: emailTextField.text ?? "", _mobile: phoneNumberTextField.text ?? "", _gender: selectedGender ?? "", _orientation: orientationDropDown.text ?? "", _interested: selectedInterest ?? "", _dob: dateOfBirthTextField.text ?? "", _termsConditions: termsAndConditions, _lookingFor: lookingForDropDown.text ?? "")
        let response = registrationModel.validate()
        if response.1 {
            print("call API")
            let registrationResponseModel = CreateAccountResponseModel(email: registrationModel.email, password: registrationModel.password, fullName: registrationModel.fullname, gender: registrationModel.gender, dateOfBirth: registrationModel.dob, orientation: registrationModel.orientation, InterestedIn: registrationModel.interested, lookingFor: registrationModel.lookingFor, mobile: registrationModel.mobile)
            networkManager.postRegistrationDetails(registrationResponseModel: registrationResponseModel)
        } else {
            print("show Alert \(response.0)")
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func termAndConditionPressed(_ sender: UIButton) {
        termsAndConditions = !termsAndConditions
        if termsAndConditions {
            termsAndConditionsImage.image = UIImage(named: "check-mark")
        } else {
            termsAndConditionsImage.image = UIImage(named: "blank-check-box")
        }
    }
    
    func setupButton(button: [UIButton]) {
        for _button in button {
            let title = _button.titleLabel?.text
            _button.backgroundColor = .white
            let attributedString = NSAttributedString(string: title ?? "",
                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 35/255, green: 15/255, blue: 100/255, alpha: 1.0)])
            _button.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    func setupUI() {
        setupButton(button: genderButton)
        setupButton(button: interestedButton)
        orientationDropDown.selectedRowColor = .lightGray
        orientationDropDown.checkMarkEnabled = false
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateOfBirthTextField.inputAccessoryView = toolbar
        dateOfBirthTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        dateOfBirthTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func didUpdateWithData(createAccountArray: [String]?, type: FetchType) {
        if let array = createAccountArray {
            DispatchQueue.main.async {
                switch type {
                case .orientation: self.orientationDropDown.optionArray = array
                case .gender: self.genderDropDown.optionArray = array
                case .interestedIn: self.interestedDropDown.optionArray = array
                case .lookingFor: self.lookingForDropDown.optionArray = array
                }
                
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateOfBirthTextField {
            showDatePicker()
        }
    }
}
