//
//  LoginPresenter.swift
//  BankProject
//
//  Created by Sayuri Hioki on 18/02/22.
//

import Foundation
import UIKit

protocol LoginPresenterDelegate: NSObjectProtocol {
    
}

typealias LoginPresentDelegate = LoginPresenterDelegate & UIViewController

class LoginPresenter {
    
    weak var delegate: LoginPresentDelegate?
    
    public func verifyLogin(_ user: String, _ password: String) -> Bool {
        if user != "_" && password != "_" {
            if user.contains("@") && user.contains(".com"){
                
            }
        } else {
            alertError("Preencha todos os campos")
        }
        
        return true
    }
    
    func alertError(_ message: String){
        let title = "Login inválido"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        delegate?.present(alert, animated: true)
    }
    
}
