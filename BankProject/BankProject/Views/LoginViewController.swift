//
//  LoginViewController.swift
//  BankProject
//
//  Created by Sayuri Hioki on 17/02/22.
//

import UIKit

protocol LoginProtocol {
    var api: APIService { get set }
}

class LoginViewController: UIViewController, LoginPresenterDelegate {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let presenter = LoginPresenter()
    let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getLogin()
        presenter.setViewDelegate(delegate: self)

        configButton()
    }

    @IBAction func login(_ sender: Any) {
        presenter.verifyLogin(userTextField.text ?? "_", passwordTextField.text ?? "_")
    }
    
    func hasUser(_ hasUser: Bool, _ user: User?) {
        if hasUser {
            print("Passed: \(true)")
            let home = HomeViewController(nibName: "HomeViewController", bundle: nil)
            home.modalPresentationStyle = .fullScreen
            home.currentUser = user
            present(home, animated: true)
        } else {
            showAlert("Dados inválidos, preencha os campos corretamente")
        }
    }
    
    
    func showAlert(_ message: String) {
        let title = "Login inválido"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    fileprivate func configButton() {
        loginButton.layer.cornerRadius = 5
        loginButton.layer.shadowColor = UIColor(named: "BankBlue")?.cgColor
        loginButton.layer.shadowOpacity = 0.25
        loginButton.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
    }
}
