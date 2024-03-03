//
//  HomeViewModel.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 19/01/2024.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    @Published var productType : productType = .wearable
    
    @Published var products : [product] = [
        product(type: .wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359" , productImage: "apple"),
        product(type: .wearable, title: "Samsung Watch", subtitle: "Gear: Black", price: "$180", productImage: "samsung" ),
        product(type:.wearable,title:"Apple Watch",subtitle:"Series 4: Black",price:"$250",productImage: "Apple watch"),
        product(type: .phones, title: "iPhone 13", subtitle : "A15 - Pink",price: "$699",productImage: "iphone 13"),
        product(type: .phones, title: "iPhone 12", subtitle: "A14 - Blue", price: "$599",productImage: "iphone 12"),
        product(type: .phones, title:
        "iPhone 11", subtitle: "A13 - Purple", price: "$499", productImage: "iphone 11"),
        product(type: .phones, title:
        "iphone 15", subtitle: "A13 - Pink", price: "$799", productImage: "iphone 15"),
        product(type: .laptops, title:
        "MacBook Air", subtitle:
        "M1 - Gold", price: "$999",
        productImage: "macbook air"),
        product(type: .laptops, title: "MacBook Pro", subtitle: "M1 - Space Grey", price: "$1299", productImage: "macbook pro"),
        product(type: .tablets, title: "iPad Pro", subtitle: "M1 - Silver", price: "$999",
        productImage: "ipad pro"),
        product(type: .tablets, title: "iPad Air 4", subtitle: "A14 - Silver", price: "$699",
        productImage: "ipad air 4"),
        product(type: .tablets, title: "iPad Mini", subtitle: "A15 - Grey", price: "$599",
        productImage: "ipad mini"), product (type: .laptops, title:
        "iMac", subtitle: "M1 - Purple", price: "$1599",
        productImage: "imac")
    ]
    
    @Published var filteredProduct : [product] = []
    @Published var showMoreProductView : Bool = false
    
    // search
    @Published var searchText : String = ""
    @Published var searchActivated : Bool = false
    @Published var searchProduct : [product]?
    var searchCancable : AnyCancellable?
    
    init(){
        filterProductByType()
        searchCancable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    
                    self.filterProductBySearch()
                    
                }else {
                    self.searchProduct = nil
                }
            })
        
            
    }
    func filterProductByType(){
        // filter product by productType....
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            // since it will require more memory so were using lazy to perform
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
            // limit result
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProduct = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        // filter product by productType....
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            // since it will require more memory so were using lazy to perform
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }

            DispatchQueue.main.async {
                self.searchProduct = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
