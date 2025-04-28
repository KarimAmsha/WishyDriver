//
//  FriendWishesListView.swift
//  Wishy
//
//  Created by Karim Amsha on 1.05.2024.
//

import SwiftUI

struct FriendWishesListView: View {
    @EnvironmentObject var appRouter: AppRouter
    let items = Array(1...4)

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                    ForEach(items, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 8) {
//                            AsyncImageView(width: 150, height: 150, cornerRadius: 10, imageURL: URL(string: "https://areej.store/wp-content/uploads/2024/01/ARJ0159987-Training-enf-36-41-3500-DZ-2.jpg"), systemPlaceholder: "photo")
//                                .cornerRadius(4)
//                                .padding(.horizontal, 6)

                            Text("حذاء Nike")
                                .customFont(weight: .bold, size: 16)
                                .foregroundColor(.primaryBlack())
                                .padding(.horizontal, 6)

                            VStack(spacing: 4) {
                                RatingView(rating: .constant(3))
                                Text("299,43 ر.س")
                                    .customFont(weight: .semiBold, size: 14)
                                    .foregroundColor(.primary())
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 16)
                        }
                        .roundedBackground(cornerRadius: 4, strokeColor: .grayEBF0FF(), lineWidth: 1)
                        .onTapGesture {
                            appRouter.navigate(to: .friendWishesDetailsView)
                        }
                    }
                }
            }
        }
        .padding(16)
        .navigationBarBackButtonHidden()
        .background(Color.background())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button {
                        appRouter.navigateBack()
                    } label: {
                        Image("ic_back")
                    }

                    Text("أمنيات صديق - شنط واكسسوار")
                        .customFont(weight: .bold, size: 20)
                        .foregroundColor(Color.primaryBlack())
                }
            }
        }
    }
}

#Preview {
    FriendWishesListView()
}
