//
//  APIService.swift
//  BankProject
//
//  Created by Sayuri Hioki on 15/03/22.
//

import Foundation
import UIKit

//typealias apiDelegate = ApiDataSource & UIViewController

class APIService: LoginPresenterDataSource, HomePresenterDataSource {
    
    func usersRequest( callback: @escaping ([User]) -> Void){
        print("entrei no service")
        guard let url = URL(string: "https://my-bankproj-api.herokuapp.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                callback(users)
            }
            catch {
                 print(error)
            }
        }
        task.resume()
    }
    
    func billsRequest(_ user: User, callback: @escaping ([Bill]) -> Void){
        guard let url = URL(string: "https://my-bankproj-api.herokuapp.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                if user.id == 1 {
                    callback(users[0].bills)
                } else if user.id == 2 {
                    callback(users[1].bills)
                }
            }
            catch {
                 print(error)
            }
        }
        task.resume()
    }
}


