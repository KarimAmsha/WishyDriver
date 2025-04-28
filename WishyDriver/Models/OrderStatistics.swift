//
//  OrderStatistics.swift
//  WishyDriver
//
//  Created by Karim Amsha on 16.06.2024.
//

import Foundation

struct OrderStatistics: Codable {
    let accpeted: Int?
    let progress: Int?
    let finished: Int?
    let cancelded: Int?
}
