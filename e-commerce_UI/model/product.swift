//
//  product.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 18/01/2024.
//

import Foundation

struct product : Identifiable , Hashable {
    let id = UUID().uuidString
    var type : productType
    var title : String
    var subtitle : String
    var description : String = ""
    var price : String
    var productImage : String = ""
    var quantity : Int = 1
}


enum productType : String , CaseIterable {
    case wearable = "Wearable"
    case laptops = "Laptops"
    case phones = "Phones"
    case tablets = "Tablets"
    
}
