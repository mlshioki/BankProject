//
//  LoginPresenter.swift
//  BankProject
//
//  Created by Sayuri Hioki on 18/02/22.
//

import Foundation
import UIKit

protocol LoginPresenterDelegate: AnyObject {
    func hasUser(_ hasUser: Bool, _ user: User?)
    func showAlert(_ message: String)
}

protocol LoginPresenterDataSource {
    func usersRequest(callback: @escaping ([User]) -> Void)
}

class LoginPresenter: LoginProtocol {
    
    weak var viewController: LoginPresenterDelegate?
    var dataSource: LoginPresenterDataSource?
    var allUsers: [User]?
    
    init(users: [User]){
        self.allUsers = users
        self.dataSource = APIService()
    }
    
    func setViewDelegate(delegate: LoginPresenterDelegate) {
        self.viewController = delegate
    }
    
    func getLogin() -> [User]{
        print("entrei no getLogin")
        
        dataSource?.usersRequest(callback: { users in
            self.allUsers = users
        })
        
        return allUsers!
        //return allUsers?[0].name == "Sayuri Hioki" ? true : false
    }
    
    func verifyLogin(_ user: String, _ password: String) -> String{
        var validation = false
        var currentUser: User?
        
        for i in 0...allUsers!.count - 1{
            if user == allUsers![i].email && password == allUsers![i].password || user == allUsers![i].cpf && password == allUsers![i].password  {
                validation = true
                currentUser = allUsers![i]
            }
        }
        viewController?.hasUser(validation, currentUser)
        
        return currentUser!.name
        
        /*let pw = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{6,}$")
        if user != "_" && password != "_" {
            if user.contains("@") && user.contains(".com"){
                validation = pw.evaluate(with: password)
            } else {
                alertError("Campos inválidos")
                validation = false
            }
        } else {
            alertError("Preencha todos os campos")
            validation = false
        }
        print("Password passed : \(validation)")*/
        
    }
    
}
