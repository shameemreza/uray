//
//  Product.swift
//  Uray
//
//  Created by Shameem Reza on 11/3/22.
//

import SwiftUI

struct Product: Identifiable {
    var id = UUID().uuidString
    var productImage: String
    var productTitle: String
    var productPrice: String
    var productColor: Color
    var productDescription: String
    var isLiked: Bool = false
    var productRating: Int
}

var products = [
Product(productImage: "product1", productTitle: "Attenir Oil", productPrice: "$25.99", productColor: Color("pcolor3"), productDescription: "Attenir Skin Clear Cleanse Oil cleanses makeup, skin stains and impurities on the skin while leaving it supple and firm.", productRating: 4),
Product(productImage: "product2", productTitle: "Attenir Lift", productPrice: "$36.0", productColor: Color("pcolor2"), productDescription: "Dress Lift Day Emulsion is Attenir's anti-ageing regenerating lifting emulsion for daily facial care.", productRating: 5),
Product(productImage: "product3", productTitle: "Recast Care", productPrice: "$52.0", productColor: Color("pcolor1"), productDescription: "Recast vitamin c facial serum is a extremely light weight serum infused with the stable form of vitamin c.", productRating: 3),
Product(productImage: "product4", productTitle: "Hawaiian Tropic", productPrice: "60.0", productColor: Color("pcolor4"), productDescription: "Let the luxurious feel and exotic scents of Hawaiian Tropic Sheer Touch take you to the tropics.", productRating: 4),
]
