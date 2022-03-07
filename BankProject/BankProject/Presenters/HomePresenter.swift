//
//  HomePresenter.swift
//  BankProject
//
//  Created by Sayuri Hioki on 18/02/22.
//

import Foundation
import UIKit

protocol BankPresenterDelegate: NSObjectProtocol {
    func presentBills(bills: [Bill])
}

typealias HomePresenterDelegate = BankPresenterDelegate & UIViewController

class HomePresenter {
    
    weak var delegate: HomePresenterDelegate?
    
    public func getBills(_ user: User){
        guard let url = URL(string: "https://my-bankproj-api.herokuapp.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                if user.id == 1 {
                self?.delegate?.presentBills(bills: users[0].bills)
                } else if user.id == 2 {
                    self?.delegate?.presentBills(bills: users[1].bills)
                }
            }
            catch {
                 print(error)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: HomePresenterDelegate) {
        self.delegate = delegate
    }
    
    public func initCollectionView(nibName: String,collectionView: UICollectionView, cellId: String){
        let nibCell = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellId)
        collectionView.reloadData()
    }
    
    public func didTap(bill: Bill){
        let title = bill.name
        let message = "\(bill.name!) está em R$\(bill.value!)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        delegate?.present(alert, animated: true)
    }
    
}
