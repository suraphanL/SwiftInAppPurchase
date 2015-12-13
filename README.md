# SwiftInAppPurchase

[![CI Status](http://img.shields.io/travis/Rawd/SwiftInAppPurchase.svg?style=flat)](https://travis-ci.org/Rawd/SwiftInAppPurchase)
[![Version](https://img.shields.io/cocoapods/v/SwiftInAppPurchase.svg?style=flat)](http://cocoapods.org/pods/SwiftInAppPurchase)
[![License](https://img.shields.io/cocoapods/l/SwiftInAppPurchase.svg?style=flat)](http://cocoapods.org/pods/SwiftInAppPurchase)
[![Platform](https://img.shields.io/cocoapods/p/SwiftInAppPurchase.svg?style=flat)](http://cocoapods.org/pods/SwiftInAppPurchase)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwiftInAppPurchase is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftInAppPurchase"
```

## Author

Rawd, suraphan.d@gmail.com

## License

SwiftInAppPurchase is available under the Apache 2.0 license. See the LICENSE file for more info.

##Production Mode
    SwiftInAppPurchase.sharedInstance.setProductionMode(false)

##Request Products
    var productIden = Set<String>()
    productIden.insert("com.irawd.test.30d")

    let iap = SwiftInAppPurchase.sharedInstance

    iap.requestProducts(productIden) { (products, invalidIdentifiers, error) -> () in
    
    }

##Purchase
    let iap = SwiftInAppPurchase.sharedInstance
    iap.addPayment("com.irawd.test.30d", userIdentifier: nil) { (result) -> () in

        switch result{
        case .Purchased(let productId,let transaction,let paymentQueue):

            paymentQueue.finishTransaction(transaction)
        case .Failed(let error):
            print(error)
        default:
            break
        }            
    }

##RefreshReceipt
    let iap = SwiftInAppPurchase.sharedInstance
    iap.refreshReceipt { (error) -> () in
        print(error)
    }
##VerifyReceipt
    let iap = SwiftInAppPurchase.sharedInstance
    iap.verifyReceipt(nil) { (receipt, error) -> () in
        print(receipt)
        print(error)
    }
##Restore
    let iap = SwiftInAppPurchase.sharedInstance
    iap.restoreTransaction(nil) { (result) -> () in
        switch result{
        case .Restored(let productId,let transaction,let paymentQueue) :
            
            paymentQueue.finishTransaction(transaction)
        case .Failed(let error):
            print(error)

        default:
        break
        }
    }       
##CheckIncompleteTransaction
    let iap = SwiftInAppPurchase.sharedInstance
    iap.checkIncompleteTransaction { (result) -> () in
        switch result{
        case .Purchased(let productId,let transaction,let paymentQueue):
            paymentQueue.finishTransaction(transaction)
        case .Restored(let productId,let transaction,let paymentQueue) :

            paymentQueue.finishTransaction(transaction)
        default:
            break
        }
    }
