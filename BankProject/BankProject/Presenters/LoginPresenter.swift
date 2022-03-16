//
//  LoginPresenter.swift
//  BankProject
//
//  Created by Sayuri Hioki on 18/02/22.
//

import Foundation
import UIKit

protocol LoginPresenterDelegate: NSObjectProtocol {
    func hasUser(_ hasUser: Bool, _ user: User?)
    func showAlert(_ message: String)
}

typealias LoginPresentDelegate = LoginPresenterDelegate & UIViewController

class LoginPresenter {
    
    weak var delegate: LoginPresentDelegate?
    let api = APIService()
    public var allUsers: [User] = []
    
    public func setViewDelegate(delegate: LoginPresentDelegate) {
        self.delegate = delegate
    }
    
    public func getLogin(){
        //let users = api.usersRequest()
        //allUsers = users
        
        guard let url = URL(string: "https://my-bankproj-api.herokuapp.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                self?.allUsers = try JSONDecoder().decode([User].self, from: data)
                
            }
            catch {
                 print(error)
            }
        }
        task.resume()
    }
    
    public func verifyLogin(_ user: String, _ password: String){
        var validation = false
        var currentUser: User?
        
        for i in 0...allUsers.count - 1{
            if user == allUsers[i].email && password == allUsers[i].password || user == allUsers[i].cpf && password == allUsers[i].password  {
                validation = true
                currentUser = allUsers[i]
            }
        }
        
        delegate?.hasUser(validation, currentUser)
        
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
