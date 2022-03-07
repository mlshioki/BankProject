//
//  LoginPresenter.swift
//  BankProject
//
//  Created by Sayuri Hioki on 18/02/22.
//

import Foundation
import UIKit

protocol LoginPresenterDelegate: NSObjectProtocol {
    func verifyUsers(_ users: [User])
}

typealias LoginPresentDelegate = LoginPresenterDelegate & UIViewController

class LoginPresenter {
    
    weak var delegate: LoginPresentDelegate?
    var allUsers: [User] = []
    
    public func getLogin(){
        guard let url = URL(string: "https://my-bankproj-api.herokuapp.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.verifyUsers(users)
                self?.allUsers = users
            }
            catch {
                 print(error)
            }
        }
        task.resume()
    }
    
    public func verifyLogin(_ user: String, _ password: String) -> [Bool: User?] {
        var validation = false
        var currentUser: User?
        
        for i in 0...allUsers.count - 1{
            if user == allUsers[i].email && password == allUsers[i].password || user == allUsers[i].cpf && password == allUsers[i].password  {
                validation = true
                currentUser = allUsers[i]
            }
        }
        
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
        
        return [validation: currentUser]
    }
    
    public func alertError(_ message: String){
        let title = "Login inválido"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        delegate?.present(alert, animated: true)
    }
    
}
