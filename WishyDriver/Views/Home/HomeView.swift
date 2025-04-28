//
//  HomeView.swift
//  Wishy
//
//  Created by Karim Amsha on 28.04.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appRouter: AppRouter
    @State private var searchText: String = ""
    let items = Array(1...10) // Example: 10 items
    let items1: [(title: String, imageURL: String)] = [
        ("Man Shirt", "shirt"),
        ("Dress", "dress"),
        ("Man Shoes", "shoes"),
        ("Woman Bag", "bag"),
    ]

    let items2: [(title: String, imageURL: String)] = [
        ("هدايا جاهزة", "g1"),
        ("أعمال العملاء", "g2"),
        ("قسم هدايا VIP", "g3"),
        ("تجهيز المناسبات الخاصة", "g4"),
    ]

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    SearchBar(text: $searchText)
                    
                    Button {
                        //
                    } label: {
                        Image("ic_bell")
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text(LocalizedStringKey.publicCategories)
                        .customFont(weight: .bold, size: 16)
                        .foregroundColor(.primaryBlack())

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(items1.indices) { index in
                                VStack(spacing: 8) {
//                                    AsyncImageView(width: 20, height: 20, cornerRadius: 0, imageURL: "".toURL(), systemPlaceholder: "photo")
//                                        .padding(25)
//                                        .roundedBackground(cornerRadius: 35, strokeColor: .grayEBF0FF(), lineWidth: 1)
//                                    .padding(.bottom, 4)

                                    Image(items1[index].imageURL)
                                        .padding(25)
                                        .roundedBackground(cornerRadius: 35, strokeColor: .grayEBF0FF(), lineWidth: 1)
                                        .padding(.bottom, 4)
                                    
                                    Text(items1[index].title)
                                        .customFont(weight: .light, size: 10)
                                        .foregroundColor(.gray9098B1())
                                }
                            }
                        }
                    }
                    
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                            ForEach(items2.indices, id: \.self) { index in
                                VStack(spacing: 8) {
//                                    AsyncImageView(width: 150, height: 150, cornerRadius: 10, imageURL: "https://m.media-amazon.com/images/I/61evxAD7n0L.jpg".toURL(), systemPlaceholder: "photo")
//                                        .cornerRadius(4)
//                                        .padding(6)

                                    Image(items2[index].imageURL)
                                        .cornerRadius(4)
                                        .padding(6)

                                    Text(items2[index].title)
                                        .customFont(weight: .bold, size: 14)
                                        .foregroundColor(.primaryBlack())
                                        .padding(.bottom, 4)
                                }
                                .roundedBackground(cornerRadius: 4, strokeColor: .grayEBF0FF(), lineWidth: 1)
                                .onTapGesture {
                                    appRouter.navigate(to: .otherWishListView)
                                }
                            }
                        }
                    }
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    HomeView()
}
