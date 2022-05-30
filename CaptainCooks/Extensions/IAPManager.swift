//
//  IAPManager.swift
//  SlotDemo
//
//  Created by Vsevolod Shelaiev on 23.08.2021.
//

import UIKit
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let shared = IAPManager()
    
    private var products = [SKProduct]()
    
    private var completion: ((Int) -> Void)?
    
    private var productBeingPurchased: SKProduct?
    
    enum Product: String, CaseIterable {
        case buy100Coins = "com.spin.casino.slots.buy10000000"
        case buy500Coins = "com.spin.casino.slots.buy50000000"
        case buy1000Coins = "com.spin.casino.slots.buy100000000"
        case buy10000Coins = "com.spin.casino.slots.buy200000000"
        
        var count: Int {
            switch self {
            case .buy100Coins:
                return 10000000
            case .buy500Coins:
                return 50000000
            case .buy1000Coins:
                return 100000000
            case .buy10000Coins:
                return 200000000
            }
        }
}
    
    
    public func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue })))
        request.delegate = self
        request.start()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { (transaction) in
            switch transaction.transactionState {
            case .purchasing:
                break
            case .purchased:
                if let product = Product(rawValue: transaction.payment.productIdentifier) {
                    completion?(product.count)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            case .failed:
                break
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
    }
    
    func requestDidFinish(_ request: SKRequest) {
        guard request is SKProductsRequest else {
            request.start()
            return
        }
        print("Product fetch request failed")
    }
    
    func purchase(product: Product,completion: @escaping((Int) -> Void)) {
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        productBeingPurchased = products.first(where: { $0.productIdentifier == product.rawValue})
        if let productpurchased = productBeingPurchased {
            self.completion = completion
            let payment = SKPayment(product: productpurchased)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        }
        
      
    }
    
}
