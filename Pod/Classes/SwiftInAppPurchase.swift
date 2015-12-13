//
//  SwiftInAppPurchase.swift
//  Pods
//
//  Created by Suraphan on 12/13/2558 BE.
//
//

import Foundation
import StoreKit

public class SwiftInAppPurchase: NSObject {
    
    public static let sharedInstance = SwiftInAppPurchase()
    
    public let productRequestHandler:ProductRequestHandler
    public let paymentRequestHandler:PaymentRequestHandler
    public let receiptRequestHandler:ReceiptRequestHandler
    
    override init() {
        self.productRequestHandler = ProductRequestHandler.init()
        self.paymentRequestHandler = PaymentRequestHandler.init()
        self.receiptRequestHandler = ReceiptRequestHandler.init()
        super.init()
    }
    
    deinit{
    }
    public func setProductionMode(isProduction:Bool){
        self.receiptRequestHandler.isProduction = isProduction
    }
    public func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    public func receiptURL() -> NSURL {
        return self.receiptRequestHandler.receiptURL()
    }
    
    //  MARK: - Product
    public func productForIdentifier(productIdentifier:String) -> SKProduct{
        return self.productRequestHandler.products[productIdentifier]!
    }
    public func requestProducts(productIDS:Set<String>,completion:RequestProductCallback){
        self.productRequestHandler.requestProduc(productIDS, requestCallback: completion)
    }
    //  MARK: - Purchase
    public func addPayment(productIDS: String,userIdentifier:String?, addPaymentCallback: AddPaymentCallback){
        let product = self.productRequestHandler.products[productIDS]
        if product != nil {
            self.paymentRequestHandler.addPayment(product!, userIdentifier: userIdentifier, addPaymentCallback: addPaymentCallback)
        }else{
            addPaymentCallback(result:.Failed(error: NSError.init(domain: "AddPayment Unknow Product identifier", code: 0, userInfo: nil)))
        }
    }
    //  MARK: - Restore
    public func restoreTransaction(userIdentifier:String?,addPaymentCallback: AddPaymentCallback){
        self.paymentRequestHandler.restoreTransaction(userIdentifier, addPaymentCallback: addPaymentCallback)
    }
    public func checkIncompleteTransaction(addPaymentCallback: AddPaymentCallback){
        self.paymentRequestHandler.checkIncompleteTransaction(addPaymentCallback)
    }
    //  MARK: - Receipt
    public func refreshReceipt(requestCallback: RequestReceiptCallback){
        self.receiptRequestHandler.refreshReceipt(requestCallback)
    }
    public func verifyReceipt(autoRenewableSubscriptionsPassword:String?,receiptVerifyCallback:ReceiptVerifyCallback){
        self.receiptRequestHandler.verifyReceipt(autoRenewableSubscriptionsPassword, receiptVerifyCallback: receiptVerifyCallback)
    }
}