//
//  GridViewItem.swift
//  WishyDriver
//
//  Created by Karim Amsha on 16.06.2024.
//

import SwiftUI

struct GridViewItem: View {
    let imageName: String
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .padding(5)
                .background(Color.primaryLight())
                .cornerRadius(8)

            Text(title)
                .customFont(weight: .bold, size: 16)
                .foregroundColor(.black)

            Text(description)
                .customFont(weight: .regular, size: 16)
                .foregroundColor(.black)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 124, alignment: .center)
        .background(Color.primaryLightHover())
        .cornerRadius(8)
        .shadow(color: Color(red: 0.93, green: 0.54, blue: 0.07).opacity(0.3), radius: 0.5, x: 0, y: 1)
    }
}

#Preview {
    GridViewItem(imageName: "", title: "", description: "")
}
