//
//  SearchBar.swift
//  Wishy
//
//  Created by Karim Amsha on 29.04.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("البحث عن رقم الطلب", text: $text)
                .customFont(weight: .regular, size: 14)
                .padding(8)
                .background(.white)
                .foregroundColor(.gray737373())
                .cornerRadius(4)

            if !text.isEmpty {
                Button(action: {
                    withAnimation {
                        text = ""
                    }
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                        .padding(8)
                }
                .transition(.move(edge: .trailing))
            }
        }
        .roundedBackground(cornerRadius: 4, strokeColor: .grayEBF0FF(), lineWidth: 1)
    }
}
