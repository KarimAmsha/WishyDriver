//
//  WishesView.swift
//  Wishy
//
//  Created by Karim Amsha on 30.04.2024.
//

import SwiftUI

struct WishesView: View {
    let items = Array(1...10)
    @State private var selectedIndex = 0
    @EnvironmentObject var appRouter: AppRouter

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    selectedIndex = 0
                }) {
                    Text(LocalizedStringKey.myWishesLists)
                        .padding()
                        .customFont(weight: selectedIndex == 0 ? .semiBold : .regular, size: 14)
                        .cornerRadius(8)
                }
                .buttonStyle(GradientPrimaryButton(fontSize: 16, fontWeight: .bold, background: selectedIndex == 0 ? Color.primaryGradientColor() : Color.grayGradientColor(), foreground: selectedIndex == 0 ? .white : .primaryBlack(), height: 37, radius: 12))

                Button(action: {
                    selectedIndex = 1
                }) {
                    Text(LocalizedStringKey.friendsWishes)
                        .padding()
                        .customFont(weight: selectedIndex == 1 ? .semiBold : .regular, size: 14)
                        .cornerRadius(8)
                }
                .buttonStyle(GradientPrimaryButton(fontSize: 16, fontWeight: .bold, background: selectedIndex == 1 ? Color.primaryGradientColor() : Color.grayGradientColor(), foreground: selectedIndex == 1 ? .white : .primaryBlack(), height: 37, radius: 12))
            }
            
            if selectedIndex == 0 {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 16)], spacing: 8) { // Reduced spacing to 8
                        ForEach(items, id: \.self) { index in
                            VStack(spacing: 8) {
                                LazyHGrid(rows: [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)], spacing: 8) {
                                    ForEach(0..<4, id: \.self) { _ in
                                        AsyncImageView(width: 65, height: 65, cornerRadius: 10, imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjgGJsjDGg3zlyeqH2RHre62EPIy3kZrWAQBYwxCgH9A&s".toURL(), systemPlaceholder: "photo")
                                            .cornerRadius(4)
                                            .padding(6)
                                    }
                                }

                                VStack {
                                    Text("شنط واكسسوار")
                                        .customFont(weight: .bold, size: 14)
                                        .foregroundColor(.primaryBlack())

                                    Text("8 عناصر")
                                        .customFont(weight: .bold, size: 14)
                                        .foregroundColor(.primary())
                                }
                                .padding(.vertical, 4)
                            }
                            .roundedBackground(cornerRadius: 4, strokeColor: .grayEBF0FF(), lineWidth: 1)
                        }
                    }
                }
            } else {
                VStack {
                    ScrollView(showsIndicators: false) {
                        ForEach(items, id: \.self) { index in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    AsyncImageView(width: 35, height: 35, cornerRadius: 17.5, imageURL: URL(string: ""), systemPlaceholder: "photo.circle")
                                    
                                    VStack(alignment: .leading) {
                                        Text("Ahmed Al-Azaiza")
                                            .customFont(weight: .semiBold, size: 12)
                                            .foregroundColor(.primaryBlack())

                                        Text("3 قوائم")
                                            .customFont(weight: .semiBold, size: 10)
                                            .foregroundColor(.gray595959())
                                    }
                                    
                                    Spacer()

                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.black292D32())
                                }
                                .padding(.vertical, 8)
                                
                                CustomDivider()
                            }
                            .onTapGesture {
                                appRouter.navigate(to: .friendWishes)
                            }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Text(LocalizedStringKey.friendMsg)
                        Spacer()
                    }
                    .customFont(weight: .bold, size: 14)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 14)
                    .foregroundColor(.primaryBlack())
                    .background(Color.grayEBF0FF().cornerRadius(4))
                    .roundedBackground(cornerRadius: 4, strokeColor: .grayD8E2FF(), lineWidth: 1)
                }
            }
        }
        .padding(16)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(LocalizedStringKey.myWishes)
                    .customFont(weight: .bold, size: 18)
                    .foregroundColor(.primaryBlack())
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //
                } label: {
                    Image("ic_bell")
                }
            }
        }
    }
}

#Preview {
    WishesView()
}
