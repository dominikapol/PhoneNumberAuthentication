//
//  PhoneNumberVC.swift
//  AuthenticationWithFirebase
//
//  Created by Dominika Poleshyck on 5.02.22.
//

import Foundation
import UIKit
import FirebaseAuth
import FlagPhoneNumber

class PhoneNumberVC: UIViewController {
    var phoneNumber: String?
    var listController: FPNCountryListViewController!
    
    @IBOutlet private weak var labelEnterPhoneNumber: UILabel!
    @IBOutlet private weak var textFieldWithPhoneNumber: FPNTextField!
    @IBOutlet private weak var getCodeButton: UIButton!
    
    @IBAction func getCode(_ sender: UIButton) {
        guard phoneNumber != nil else { return }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { verificationID, error in
            if error != nil {
                print(error?.localizedDescription ?? "is empty")
            } else {
                self.showCodeValidVC(verificationID: verificationID)
            }
        }
    }
    
    private func showCodeValidVC(verificationID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "CodeValidVC") as! CodeValidVC
        dvc.verificationID = verificationID
        self.present(dvc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConfigurations()
    }
    
    private func setUpConfigurations() {
        getCodeButton.alpha = 0.5
        getCodeButton.isEnabled = false
        textFieldWithPhoneNumber.delegate = self
        textFieldWithPhoneNumber.displayMode = .list
        
        listController = FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: textFieldWithPhoneNumber.countryRepository)
        listController.didSelect = { country in
            self.textFieldWithPhoneNumber.setFlag(countryCode: country.code)
        }
        
    }
}

extension PhoneNumberVC: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        ///
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            getCodeButton.alpha = 1
            getCodeButton.isEnabled = true
            phoneNumber = textField.getFormattedPhoneNumber(format: .International)
        } else {
            getCodeButton.alpha = 0.5
            getCodeButton.isEnabled = false
        }
    }
    
    func fpnDisplayCountryList() {
        let navigationController = UINavigationController(rootViewController: listController)
        listController.title = "Countries"
        textFieldWithPhoneNumber.text = ""
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
}
