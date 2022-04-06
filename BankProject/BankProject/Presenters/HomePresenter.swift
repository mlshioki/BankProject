//
//  HomePresenter.swift
//  BankProject
//
//  Created by Sayuri Hioki on 18/02/22.
//

import Foundation
import UIKit

protocol HomePresenterDelegate: AnyObject {
    func presentBills(bills: [Bill])
    func showAlert(_ title: String, _ message: String)
}

protocol HomePresenterDataSource {
    func billsRequest(_ user: User, callback: @escaping ([Bill]) -> Void)
}

class HomePresenter: HomeProtocol {
    
    weak var viewController: HomePresenterDelegate?
    var dataSource: HomePresenterDataSource?
    var billsArray: [Bill]?
    
    init(){
        self.dataSource = APIService()
    }
    
    public func getBills(_ user: User) -> [Bill]{
        dataSource?.billsRequest(user, callback: { bill in
            self.viewController?.presentBills(bills: bill)
            self.billsArray = bill
        })
        return billsArray!
    }
    
    public func setViewDelegate(delegate: HomePresenterDelegate) {
        self.viewController = delegate
    }
    
    func didTap(_ bill: Bill) -> Bool{
        print("entrei")
        var title = ""
        title = bill.name!
        let message = "\(bill.name!) está em R$\(bill.value!)"
        
        viewController?.showAlert(title, message)
        
        let validation = title == "" ? false : true
        
        return validation
    }
    
    public func formatAcc(_ accNumber: String) -> String{
        return ("\(transformString(accNumber, 0, 3))/\(transformString(accNumber, 4, 5)).\(transformString(accNumber, 6, 11))-\(String(accNumber[12]))")
    }
    
    func transformString(_ x: String,_ start: Int,_ end: Int) -> String{
        var response: String = ""
        
        for i in start...end{
            response += String(x[i])
        }
        
        return response
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
