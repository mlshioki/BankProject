//
//  LoginTests.swift
//  BankProjectTests
//
//  Created by Sayuri Hioki on 07/03/22.
//

import XCTest
@testable import BankProject

class LoginTests: XCTestCase {
    
    var usuario: User!
    let presenter = LoginPresenter()
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeveAceitarEmail(){
        getlogin()
        XCTAssertEqual([true: "Sayuri Hioki"], presenter.verifyLogin("hiokisayuri@brq.com", "Itau02*"))
    }
    
    
}
