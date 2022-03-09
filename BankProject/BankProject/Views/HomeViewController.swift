//
//  CurrencyViewController.swift
//  BankProject
//
//  Created by Sayuri Hioki on 17/02/22.
//

import UIKit

class HomeViewController: UIViewController, BankPresenterDelegate {
    
    
    @IBOutlet weak var usersName: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var balance: UILabel!
    let collectionViewCellId = "billCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentUser: User!
    var bills = [Bill]()
    
    private let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bills = currentUser.bills
        usersName.text = currentUser.name
        accountNumber.text = presenter.formatAcc(String(currentUser.accountNumber))
        balance.text = "R$\(currentUser.balance)"
        // Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getBills(currentUser)
        
        //register cell
        //collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: collectionViewCellId)
        presenter.initCollectionView("CollectionViewCell", collectionView, collectionViewCellId)
        
    }
    
    @IBAction func logout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func presentBills(bills: [Bill]) {
        self.bills = bills
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

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
        presenter.didTap(bill)
        print (bill.name as Any)
    }
    
}
