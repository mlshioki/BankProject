//
//  CurrencyViewController.swift
//  BankProject
//
//  Created by Sayuri Hioki on 17/02/22.
//

import UIKit

protocol HomeProtocol {
    func didTap(_ bill: Bill)
}

typealias homeProtocol = HomeProtocol & UIViewController

class HomeViewController: UIViewController, BankPresenterDelegate {
    
    @IBOutlet weak var usersNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    let collectionViewCellId = "billCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentUser: User!
    var bills = [Bill]()
    
    var delegate: homeProtocol?
    private let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getBills(currentUser)
        
        //set user data
        bills = currentUser.bills
        usersNameLabel.text = "Olá, \(currentUser.name)!"
        accountNumberLabel.text = presenter.formatAcc(String(currentUser.accountNumber))
        balanceLabel.text = "R$\(currentUser.balance)"
        
        //register cell
        initCollectionView("CollectionViewCell", collectionView, collectionViewCellId)
        
    }
    
    @IBAction func logout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func initCollectionView(_ nibName: String,_ collectionView: UICollectionView,_ cellId: String){
        let nibCell = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellId)
        collectionView.reloadData()
    }
    
    //MARK: - Protocol functions
    func presentBills(bills: [Bill]) {
        self.bills = bills
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

//MARK: - Extension
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as! CollectionViewCell
        let bill = bills[indexPath.row]
        
        cell.configCell(with: bill)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 400.0, height: 80.0)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bill = bills[indexPath.row]
        self.delegate?.didTap(bill)
        print (bill.name as Any)
    }
    
}
