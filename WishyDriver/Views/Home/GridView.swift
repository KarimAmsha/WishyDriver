//
//  GridView.swift
//  WishyDriver
//
//  Created by Karim Amsha on 16.06.2024.
//

import SwiftUI

struct GridView: View {
    let orderStatistics: OrderStatistics?

    var body: some View {
        if let orderStatistics = orderStatistics {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                GridViewItem(imageName: "ic_logo", title: LocalizedStringKey.accepted, description: orderStatistics.accpeted?.toString() ?? "")
                GridViewItem(imageName: "ic_logo", title: LocalizedStringKey.progress, description: orderStatistics.progress?.toString() ?? "")
                GridViewItem(imageName: "ic_logo", title: LocalizedStringKey.finished, description: orderStatistics.finished?.toString() ?? "")
                GridViewItem(imageName: "ic_logo", title: LocalizedStringKey.canceled, description: orderStatistics.cancelded?.toString() ?? "")
            }
            .padding()
        } else {
            // Handle the case where orderStatistics is nil
            LoadingView()
        }
    }
}
