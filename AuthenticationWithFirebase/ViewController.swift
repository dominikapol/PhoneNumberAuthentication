//
//  ViewController.swift
//  AuthenticationWithFirebase
//
//  Created by Dominika Poleshyck on 4.02.22.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    @IBAction func logOutSegue(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func authTapped(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "PhoneNumberVC") as! PhoneNumberVC
        self.present(dvc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            if Auth.auth().currentUser?.uid != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let dvc = storyboard.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
                present(dvc, animated: true, completion: nil)
            }
        }
    }
    
}

