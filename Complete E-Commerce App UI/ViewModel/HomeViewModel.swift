//
//  HomeViewModel.swift
//  Complete E-Commerce App UI
//
//  Created by Boris Zinovyev on 09.02.2022.
//

import SwiftUI

class HomeViewModel: ObservableObject {
//  Первой будет выюрана категория (аксессуары)
    @Published var productType: ProductType = .Wearable
    
//  Data
    @Published var products: [Product] = [
        Product(type: .Wearable, title: "Apple Watch", subTitle: "Series 7, 45mm", price: "$359", productImage: "Watch7"),
        Product(type: .Wearable, title: "Apple Watch", subTitle: "Series SE, 45mm", price: "$279", productImage: "WatchSE"),
        Product(type: .Wearable, title: "Apple Watch", subTitle: "Series 3 - Nike", price: "$299", productImage: "WatchNike"),
        Product(type: .Laptops, title: "Macbook Air", subTitle: "M1, 8GB, 256GB", price: "$999", productImage: "MacbookAir"),
        Product(type: .Laptops, title: "Macbook Pro", subTitle: "M1 Pro, 16GB, 512GB", price: "$1999", productImage: "MacbookPro"),
        Product(type: .Phones, title: "IPhone 13", subTitle: "ProMax, 512GB", price: "$899", productImage: "IPhone13")
    ]
    
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    
    
// Перелистывание категорий
    @Published var filteredProducts: [Product] = []
    
    init() {
        filterProductByType()
    }
    
    func filterProductByType() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
                .lazy
                .filter { product in
                    return product.type == self.productType
            }
// лимит показа объектов
            .prefix(4)
        
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}

