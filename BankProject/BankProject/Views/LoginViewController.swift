//
//  LoginViewController.swift
//  BankProject
//
//  Created by Sayuri Hioki on 17/02/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let presenter = LoginPresenter()
    
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getLogin()

        loginButton.layer.cornerRadius = 5
        loginButton.layer.shadowColor = UIColor(named: "BankBlue")?.cgColor
        loginButton.layer.shadowOpacity = 0.25
        loginButton.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
    }

    @IBAction func login(_ sender: Any) {
        let verify = presenter.verifyLogin(userTextField.text ?? "_", passwordTextField.text ?? "_")
        
        if verify.keys.contains(true) {
            print("Passed: \(true)")
            let home = HomeViewController(nibName: "HomeViewController", bundle: nil)
            home.modalPresentationStyle = .fullScreen
            home.currentUser = verify.first?.value
            present(home, animated: true)
            
            //navigationController?.pushViewController(home, animated: true)
        } else {
            presenter.alertError("Dados inválidos, preencha os campos corretamente")
        }
    }
    
    func verifyUser(_ users: [User]){
        self.users = users
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
