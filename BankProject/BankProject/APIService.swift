//
//  APIService.swift
//  BankProject
//
//  Created by Sayuri Hioki on 15/03/22.
//

import Foundation
import UIKit

protocol ApiDataSource {
    var allUsers: [User] { get set }
    func getUsers(_ users: [User])
}

typealias apiDelegate = ApiDataSource & UIViewController

class APIService: LoginPresenterDataSource {
    
    weak var delegate: apiDelegate?
    
    func usersRequest(){
        print("entrei no service")
        guard let url = URL(string: "https://my-bankproj-api.herokuapp.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.getUsers(users)
            }
            catch {
                 print(error)
            }
        }
        task.resume()
    }
}


