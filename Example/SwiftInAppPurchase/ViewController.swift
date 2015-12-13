//
//  ViewController.swift
//  IAPMaster
//
//  Created by Suraphan on 11/29/2558 BE.
//  Copyright © 2558 irawd. All rights reserved.
//

import UIKit
import SwiftInAppPurchase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func requestProduct(sender: AnyObject) {
        var productIden = Set<String>()
        productIden.insert("com.irawd.test.30d")
        
        let iap = SwiftInAppPurchase.sharedInstance
        
        iap.requestProducts(productIden) { (products, invalidIdentifiers, error) -> () in
            print(products)
            print(invalidIdentifiers)
            print(error)
        }
    }

    @IBAction func purchase(sender: AnyObject) {
        let iap = SwiftInAppPurchase.sharedInstance
        iap.addPayment("com.irawd.test.30d", userIdentifier: nil) { (result) -> () in
            
            switch result{
            case .Purchased(let productId,let transaction,let paymentQueue):
                print(productId)
                print(transaction)
                print(paymentQueue)
                paymentQueue.finishTransaction(transaction)
            case .Failed(let error):
                print(error)
            default:
                break
            }            
        }
    }
    @IBAction func RefreshReceipt(sender: AnyObject) {
        let iap = SwiftInAppPurchase.sharedInstance
        iap.refreshReceipt { (error) -> () in
            print(error)
        }
    }
    
    
    @IBAction func verifyReceipt(sender: AnyObject) {
        let iap = SwiftInAppPurchase.sharedInstance
        iap.verifyReceipt(nil) { (receipt, error) -> () in
            print(receipt)
            print(error)
        }
    }
    
    
    @IBAction func restore(sender: AnyObject) {
        let iap = SwiftInAppPurchase.sharedInstance
        iap.restoreTransaction(nil) { (result) -> () in
            switch result{
            case .Restored(let productId,let transaction,let paymentQueue) :
                print(productId)
                print(transaction)
                print(paymentQueue)
                paymentQueue.finishTransaction(transaction)
            case .Failed(let error):
                print(error)
                
            default:
                break
            }
        }        
    }
    @IBAction func checkIncompleteTransaction(sender: AnyObject) {
        let iap = SwiftInAppPurchase.sharedInstance
        iap.checkIncompleteTransaction { (result) -> () in
            switch result{
            case .Purchased(let productId,let transaction,let paymentQueue):
                print(productId)
                print(transaction)
                print(paymentQueue)
                paymentQueue.finishTransaction(transaction)
            case .Restored(let productId,let transaction,let paymentQueue) :
                print(productId)
                print(transaction)
                print(paymentQueue)
                paymentQueue.finishTransaction(transaction)
            default:
                break
            }
        }
        
    }
}

