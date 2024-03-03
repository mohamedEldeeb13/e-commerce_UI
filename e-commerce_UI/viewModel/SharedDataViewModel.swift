//
//  SharedDataViewModel.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 20/01/2024.
//

import SwiftUI

class SharedDataViewModel: ObservableObject {
    
    @Published var detailsProduct : product?
    @Published var showDetailsView : Bool = false
    // match geometry effect from search page
    @Published var fromSearchPage : Bool = false
    
    // liked products
    @Published var likedProduct : [product] = []
    // basket products
    @Published var cartProduct : [product] = []
    
    // calculate total price
    func getTotalPrice() -> String {
        var total : Int = 0
        cartProduct.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            total += priceTotal
        }
        return "$\(total)"
    }
    
}

