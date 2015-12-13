//
//  PaymentRequestHandler.swift
//  IAPMaster
//
//  Created by Suraphan on 11/30/2558 BE.
//  Copyright © 2558 irawd. All rights reserved.
//


import StoreKit

public enum TransactionResult {
    case Purchased(productId: String,transaction:SKPaymentTransaction,paymentQueue:SKPaymentQueue)
    case Restored(productId: String,transaction:SKPaymentTransaction,paymentQueue:SKPaymentQueue)
    case NothingToDo
    case Failed(error: NSError)
}
public typealias AddPaymentCallback = (result: TransactionResult) -> ()

public class PaymentRequestHandler: NSObject,SKPaymentTransactionObserver {

    
    private var addPaymentCallback: AddPaymentCallback?
    private var incompleteTransaction : [SKPaymentTransaction] = []
    override init() {
        super.init()
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
    }
    deinit {
        SKPaymentQueue.defaultQueue().removeTransactionObserver(self)
    }
    
    func addPayment(product: SKProduct,userIdentifier:String?, addPaymentCallback: AddPaymentCallback){
        
        self.addPaymentCallback = addPaymentCallback
        
        let payment = SKMutablePayment(product: product)
        if userIdentifier != nil {
            payment.applicationUsername = userIdentifier!
        }
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }

    func restoreTransaction(userIdentifier:String?,addPaymentCallback: AddPaymentCallback){
        
        self.addPaymentCallback = addPaymentCallback
        if userIdentifier != nil {
           SKPaymentQueue.defaultQueue().restoreCompletedTransactionsWithApplicationUsername(userIdentifier)
        }else{
            SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
        }
        
    }
    public func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]){
    
        for transaction in transactions {
            switch transaction.transactionState {
            case .Purchased:
                if (addPaymentCallback != nil){
                    addPaymentCallback!(result:.Purchased(productId: transaction.payment.productIdentifier, transaction: transaction, paymentQueue: queue))
                }else{
                    incompleteTransaction.append(transaction)
                }
                
            case .Failed:
                if (addPaymentCallback != nil){
                    addPaymentCallback!(result:.Failed(error: transaction.error!))
                }
                queue.finishTransaction(transaction)
               
            case .Restored:
                if (addPaymentCallback != nil){
                    addPaymentCallback!(result:.Restored(productId: transaction.payment.productIdentifier, transaction: transaction, paymentQueue: queue))
                }else{
                    incompleteTransaction.append(transaction)
                }

            case .Purchasing:
                // In progress: do nothing
                break
            case .Deferred:
                break
            }

        }
    }
    
    
    func checkIncompleteTransaction(addPaymentCallback: AddPaymentCallback){
     
        self.addPaymentCallback = addPaymentCallback
        let queue = SKPaymentQueue.defaultQueue()
        for transaction in self.incompleteTransaction {
            
            switch transaction.transactionState {
            case .Purchased:
                addPaymentCallback(result:.Purchased(productId: transaction.payment.productIdentifier, transaction: transaction, paymentQueue: queue))
                
            case .Restored:
                addPaymentCallback(result:.Restored(productId: transaction.payment.productIdentifier, transaction: transaction, paymentQueue: queue))
                
            default:
                break
            }
        }
        self.incompleteTransaction.removeAll()
    }
}
