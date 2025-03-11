//
//  Product.swift
//  examenIOS
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
}
