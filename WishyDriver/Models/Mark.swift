//
//  Mark.swift
//  WishyDriver
//
//  Created by Karim Amsha on 16.06.2024.
//

import Foundation
import MapKit

struct Mark: Identifiable, Hashable {
    let id = UUID()
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var show: Bool = false
    var imageName: String? 
    var isUserLocation: Bool = false
}

