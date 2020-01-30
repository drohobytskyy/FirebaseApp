//
//  Utils.swift
//  FireStoreApp
//
//  Created by @rtur drohobytskyy on 29/01/2020.
//  Copyright © 2020 @rtur drohobytskyy. All rights reserved.
//

import UIKit

class Utils {
    
    static let shared: Utils = Utils()
    
    func customTextField(_ textField: UITextField) {
        
        let line = CALayer()
        line.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
        line.backgroundColor = UIColor.darkGray.cgColor
        
        textField.borderStyle = .none
        textField.layer.addSublayer(line)
    }
    
    func customButton(_ button: UIButton, _ type: ButtonTypeEnum) {
        
        switch type.description {
            
        case ButtonTypeEnum.signUp.description:
            button.backgroundColor = .darkGray
            button.layer.cornerRadius = 20.0
            button.tintColor = .white
        case ButtonTypeEnum.login.description:
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 20
            button.tintColor = .black
        default:
            break
        }
    }
    
    func isPasswordValid(username: String, password:String) -> Bool{
        
        if password.count < 8 {
           return false
        }
        
        if (password.range(of:"[\\W]", options: .regularExpression) == nil){
             return false
        }
        
        if (username == password){
             return false
        }
        
        return true
    }

}

enum ButtonTypeEnum: CustomStringConvertible {
    
    case signUp
    case login
    
    var description: String{
        switch self {
        case ButtonTypeEnum.signUp:
            return "signUp"
        case ButtonTypeEnum.login:
            return "login"
        }
       
    }
}
