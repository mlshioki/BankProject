//
//  CollectionViewCell.swift
//  BankProject
//
//  Created by Sayuri Hioki on 18/02/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var bill: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        view.layer.cornerRadius = 5
//        view.layer.shadowColor = UIColor(named: "BankBlue")?.cgColor
//        view.layer.shadowOpacity = 0.25
//        view.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
    }
    
    func configCell(with bill: Bill){
        self.bill.text = bill.name
        value.text = "R$" + bill.value!
        date.text = bill.date
    }

}
