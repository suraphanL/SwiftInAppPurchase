//
//  ProductRequestHandler.swift
//  IAPMaster
//
//  Created by Suraphan on 11/30/2558 BE.
//  Copyright © 2558 irawd. All rights reserved.
//
import StoreKit

public typealias RequestProductCallback = (products: [SKProduct]?,invalidIdentifiers:[String]?,error:NSError?) -> ()

public class ProductRequestHandler: NSObject,SKProductsRequestDelegate {
    
    private var requestCallback: RequestProductCallback?
    var products: [String: SKProduct] = [:]
    
    override init() {
        super.init()
    }
    deinit {
        
    }
    func addProduct(product: SKProduct) {
        products[product.productIdentifier] = product
    }

    func requestProduc(productIds: Set<String>, requestCallback: RequestProductCallback){
        self.requestCallback = requestCallback
        let productRequest = SKProductsRequest(productIdentifiers: productIds)
        productRequest.delegate = self
        productRequest.start()
    }
    // MARK: SKProductsRequestDelegate
    public func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        
        for product in response.products{
            addProduct(product)
        }
        requestCallback!(products: response.products, invalidIdentifiers: response.invalidProductIdentifiers, error: nil)
    }

    public func requestDidFinish(request: SKRequest) {
        print(request)
    }
    public func request(request: SKRequest, didFailWithError error: NSError) {
        requestCallback!(products: nil, invalidIdentifiers: nil, error: error)
    }
    
}
