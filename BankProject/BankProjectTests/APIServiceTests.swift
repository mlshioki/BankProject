//
//  APIServiceTests.swift
//  BankProjectTests
//
//  Created by Sayuri Hioki on 05/04/22.
//

import XCTest
@testable import BankProject

class APIServiceTests: XCTestCase {
    
    var dataSource: LoginPresenterDataSource? = APIService()
    var allUsers: [User] = []
    
    override func setUpWithError() throws {
        dataSource = APIService()
        allUsers = []
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testPerformance() throws {
        self.measure {
            dataSource?.usersRequest(callback: { users in
                self.allUsers = users
            })
        }
    }

}
