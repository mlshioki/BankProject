//
//  LoginTests.swift
//  BankProjectTests
//
//  Created by Sayuri Hioki on 07/03/22.
//

import XCTest
@testable import BankProject

class LoginPresenterTests: XCTestCase {
    
    //var usuario: User!
    var presenter: LoginProtocol?
    //var viewController: LoginViewController!
    
    override func setUpWithError() throws {
        presenter = LoginPresenter(users: [User]())
        //viewController = LoginViewController()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        presenter = nil
    }
    
    func testPuxarUsuariosDaAPI(){
        let validacao = presenter?.getLogin()
        XCTAssertEqual(false, validacao?.isEmpty)
    }
    
    func testDeveAceitarEmail(){
        presenter?.getLogin()
        let validacao = presenter?.verifyLogin("hiokisayuri@brq.com", "Itau02*")
        XCTAssertEqual("Sayuri Hioki", validacao)
    }
    
    func testDeveAceitarCPF(){
        presenter?.getLogin()
        let validacao = presenter?.verifyLogin("44046521864", "Itau02*")
        XCTAssertEqual("Sayuri Hioki", validacao)
    }
    
    
}
