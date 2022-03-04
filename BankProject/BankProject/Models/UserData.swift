//
//  UserData.swift
//  BankProject
//
//  Created by Sayuri Hioki on 18/02/22.
//

import Foundation

struct User: Codable {
    
    let name: String
    let email: String
    let cpf: String
    let password: String
    let accountNumber: Int
    let balance: Double
    let id: UUID
    let bills: [Bill]
}
