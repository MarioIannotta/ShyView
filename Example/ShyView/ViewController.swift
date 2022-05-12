//
//  ViewController.swift
//  ShyView
//
//  Created by MarioIannotta on 04/21/2022.
//  Copyright (c) 2022 MarioIannotta. All rights reserved.
//

import UIKit
import ShyView

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

class ViewController: UIViewController {

    private var transactions: [Transaction] = [
        .init(text: "Money transfer to Steve Foo", date: "20/05/2022", amount: -100),
        .init(text: "Check 1023: Gym", date: "18/04/2022", amount: -30),
        .init(text: "Cash deposit from ATM", date: "01/03/2022", amount: 50),
        .init(text: "Online payment to Acme Inc", date: "22/12/2021", amount: -110),
        .init(text: "Online payment to Foo corp", date: "04/10/2021", amount: -320),
        .init(text: "Money transfer from Jack Jackson", date: "02/10/2021", amount: 4242),
        .init(text: "Money transfer: Bob Bar", date: "14/09/2021", amount: -400),
        .init(text: "Online payment to Acme Inc", date: "22/8/2021", amount: -1120),
    ]
    
    @IBOutlet private weak var headerStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let balanceLabel = UILabel()
        balanceLabel.text = "123,456€"
        balanceLabel.textColor = .white
        
        headerStackView.addArrangedSubview(balanceLabel.avoidScreenshots())
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        cell.configure(transaction: transactions[indexPath.row])
        return cell
    }
}

struct Transaction {
    let text: String
    let date: String
    let amount: Int
    
    var category: String {
        amount > 0 ? "💰" : "💸"
    }
}

class TransactionCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var contentStackView: UIStackView!
    
    let amountLabel = UILabel()
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentStackView.addArrangedSubview(ShyView(amountLabel) ?? amountLabel)
    }
    
    func configure(transaction: Transaction) {
        titleLabel.text = transaction.text
        dateLabel.text = transaction.date
        amountLabel.text = formatter.string(from: NSNumber(value: transaction.amount))
        categoryLabel.text = transaction.category
    }
}
