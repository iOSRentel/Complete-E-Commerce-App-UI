//
//  File.swift
//  Complete E-Commerce App UI
//
//  Created by Boris Zinovyev on 09.02.2022.
//

import SwiftUI

//MARK: DataModel
struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subTitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}
//MARK: -Категории
enum ProductType: String, CaseIterable {
    case Wearable = "Wearable"
    case Laptops = "Laptops"
    case Phones = "Phones"
    case Tablets = "Tablets"
}
