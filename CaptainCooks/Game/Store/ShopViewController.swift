//
//  ShopViewController.swift
//  JackotCity
//
//  Created by Vsevolod Shelaiev on 21.12.2021.
//

import UIKit

class ShopViewController: BaseVC {

    enum Product: String, CaseIterable {
        case buy100Coins = "com.spin.casino.slots.buy10000000"
        case buy500Coins = "com.spin.casino.slots.buy50000000"
        case buy1000Coins = "com.spin.casino.slots.buy100000000"
        case buy10000Coins = "com.spin.casino.slots.buy200000000"
    }
    
    @IBOutlet weak var centralView: UIView!
    
    @IBAction func buy100Coins(_ sender: Any) {
        IAPManager.shared.purchase(product: .buy100Coins, completion: { [weak self] count in
            DispatchQueue.main.async {
                self?.addCoins(count: count)
            }
        })
    }
    
    @IBAction func buy500Coins(_ sender: Any) {
        IAPManager.shared.purchase(product: .buy500Coins, completion: { [weak self] count in
            DispatchQueue.main.async {
                self?.addCoins(count: count)
            }
        })
    }
    
    
    @IBAction func buy1000Coins(_ sender: Any) {
        IAPManager.shared.purchase(product: .buy1000Coins, completion: { [weak self] count in
            DispatchQueue.main.async {
                self?.addCoins(count: count)
            }
        })
    }
    
    
    @IBAction func buy10000Coins(_ sender: Any) {
        IAPManager.shared.purchase(product: .buy10000Coins, completion: { [weak self] count in
            DispatchQueue.main.async {
                self?.addCoins(count: count)
            }
        })
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        self.navigationController!.popViewController(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralView.layer.cornerRadius = 12
    }
    
    private func addCoins(count: Int) {
        let currentCount = Level.shared.coinsPool
        let newCount = currentCount + count
        Level.shared.coinsPool = newCount
    }

}
