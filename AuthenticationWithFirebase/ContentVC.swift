//
//  ContentVC.swift
//  AuthenticationWithFirebase
//
//  Created by Dominika Poleshyck on 7.02.22.
//

import UIKit
import FirebaseAuth

class ContentVC: UIViewController {
    
    @IBAction func logOut(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logOutSegue:", sender: self )
        } catch {
            
        }
    } 
}
