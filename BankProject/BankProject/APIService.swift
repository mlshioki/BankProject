//
//  APIService.swift
//  BankProject
//
//  Created by Sayuri Hioki on 15/03/22.
//

import Foundation

protocol ApiDataSource {
    
}

class APIService{
    
    public func usersRequest() -> [User] {
        var users = [User]()
        guard let url = URL(string: "https://my-bankproj-api.herokuapp.com/users") else { return users }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                users = try JSONDecoder().decode([User].self, from: data)
                
            }
            catch {
                 print(error)
            }
        }
        task.resume()
        return users
    }
}


