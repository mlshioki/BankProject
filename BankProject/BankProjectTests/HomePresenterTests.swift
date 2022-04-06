//
//  HomePresenterTests.swift
//  BankProjectTests
//
//  Created by Sayuri Hioki on 30/03/22.
//

import XCTest
@testable import BankProject

class HomePresenterTests: XCTestCase {
    
    var loginPresenter: LoginProtocol?
    var homePresenter: HomeProtocol?

    override func setUpWithError() throws {
        loginPresenter = LoginPresenter(users: [User]())
        homePresenter = HomePresenter()
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        homePresenter = nil
    }

    func testDeveBuscarContas(){
        let usuarios = loginPresenter?.getLogin()
        let contas = homePresenter?.getBills(usuarios![0])
        XCTAssertEqual(false, contas?.isEmpty)
        //homePresenter?.getBills(loginPresenter?.allUsers[0])
    }
    
    func testDeveMostrarPopUp(){
        let usuarios = loginPresenter?.getLogin()
        let contas = homePresenter?.getBills(usuarios![0])
        let validacao = homePresenter?.didTap(contas![0])
        
        XCTAssertEqual(true, validacao)
    }

}
