//
//  UserBillsData.swift
//  BankProject
//
//  Created by Sayuri Hioki on 18/02/22.
//

import Foundation

struct Bill: Codable {
    var name: String?
    var date: String?
    var value: String?
    var id: Int
}
