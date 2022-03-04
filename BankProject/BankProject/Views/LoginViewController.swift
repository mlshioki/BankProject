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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 5
        loginButton.layer.shadowColor = UIColor(named: "BankBlue")?.cgColor
        loginButton.layer.shadowOpacity = 0.25
        loginButton.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
    }

    @IBAction func login(_ sender: Any) {
        if presenter.verifyLogin(userTextField.text ?? "_", passwordTextField.text ?? "_") {
            let home = HomeViewController(nibName: "HomeViewController", bundle: nil)
        }
        //let home = HomeViewController(nibName: "HomeViewController", bundle: nil)
        
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
