//
//  CodeValidVC.swift
//  AuthenticationWithFirebase
//
//  Created by Dominika Poleshyck on 6.02.22.
//

import UIKit
import FirebaseAuth

class CodeValidVC: UIViewController {
    var verificationID: String!
    
    @IBOutlet weak var codeTextView: UITextView!
    @IBOutlet weak var enterLabel: UILabel!
    @IBOutlet weak var checkCodeButton: UIButton!
    
    @IBAction func checkCodeTapped(_ sender: Any) {
        guard let code = codeTextView.text else { return }
        
        let credetional = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        Auth.auth().signIn(with: credetional) { _, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.showContectVC()
            }
        }
    }
    
    private func showContectVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
        self.present(dvc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeTextView.delegate = self
        
    }
    
    private func setUpConfigurations() {
        checkCodeButton.alpha = 0.5
        checkCodeButton.isEnabled = false
        
    }
}


extension CodeValidVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        } else {
            let newLength = currentCharacterCount + text.count - range.length
            return newLength <= 6
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 6 {
            checkCodeButton.alpha = 1
            checkCodeButton.isEnabled = true
        } else {
            checkCodeButton.alpha = 0.5
            checkCodeButton.isEnabled = false
        }
    }
}
