//
//  OtherWishListView.swift
//  Wishy
//
//  Created by Karim Amsha on 30.04.2024.
//

import SwiftUI

struct OtherWishListView: View {
    let items = Array(1...10)
    @EnvironmentObject var appRouter: AppRouter
    @State var selectedIndex = 0

    var body: some View {
        VStack {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(0..<10) { index in
//                        Button {
//                            selectedIndex = index
//                        } label: {
//                            Text("كل الهدايا")
//                        }
//                        .buttonStyle(GradientPrimaryButton(fontSize: 14, fontWeight: selectedIndex == index ? .bold : .regular, background: selectedIndex == index ? Color.primaryGradientColor() : Color.grayGradientColor(), foreground: selectedIndex == index ? .white : .primaryBlack(), height: 37, radius: 4))
//                    }
//                }
//            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text(LocalizedStringKey.specialCategories)
                    .customFont(weight: .bold, size: 16)
                    .foregroundColor(.primaryBlack())

//                ScrollView(showsIndicators: false) {
//                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
//                        ForEach(items, id: \.self) { index in
//                            VStack(alignment: .leading, spacing: 8) {
//                                AsyncImageView(width: 150, height: 150, cornerRadius: 10, imageURL: URL(string: "https://media.zid.store/cdn-cgi/image/f=auto/https://media.zid.store/ca6f01a7-f802-4c28-b793-b6c642a7f178/42610e71-37fa-471e-aa72-b5e11fb658a7.jpg"), systemPlaceholder: "photo")
//                                    .cornerRadius(4)
//                                    .padding(.horizontal, 6)
//
//                                Text("سلة ورد")
//                                    .customFont(weight: .bold, size: 16)
//                                    .foregroundColor(.primaryBlack())
//                                    .padding(.horizontal, 6)
//
//                                VStack(spacing: 4) {
//                                    RatingView(rating: .constant(3))
//                                    Text("299,43 ر.س")
//                                        .customFont(weight: .semiBold, size: 14)
//                                        .foregroundColor(.primary())
//                                }
//                                .padding(.horizontal, 6)
//                                .padding(.vertical, 16)
//                            }
//                            .roundedBackground(cornerRadius: 4, strokeColor: .grayEBF0FF(), lineWidth: 1)
//                            .onTapGesture {
//                                appRouter.navigate(to: .productDetails)
//                            }
//                        }
//                    }
//                }
            }

            Spacer()
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

                    Text("استكشف الهدايا جاهزة")
                        .customFont(weight: .bold, size: 20)
                        .foregroundColor(Color.primaryBlack())
                }
            }
        }
    }
}

#Preview {
    OtherWishListView()
}
