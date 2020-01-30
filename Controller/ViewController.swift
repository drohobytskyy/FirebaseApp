//
//  ViewController.swift
//  FireStoreApp
//
//  Created by @rtur drohobytskyy on 28/01/2020.
//  Copyright © 2020 @rtur drohobytskyy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    private var authListener: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - layout
    private func setupLayout() {
        
        Utils.shared.customButton(signUpBtn, ButtonTypeEnum.signUp)
        Utils.shared.customButton(loginBtn, ButtonTypeEnum.login)
    }
    
    
    // MARK: - helpers
    private func transitionToHomeVC() {
        
        let homeVc = storyboard?.instantiateViewController(withIdentifier: GlobalConstants.ViewControllers.HomeController) as? HomeController
        
        view.window?.rootViewController = homeVc
        view.window?.makeKeyAndVisible()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authListener = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user != nil {
              self.transitionToHomeVC()
            }
        }
    }
    
}

