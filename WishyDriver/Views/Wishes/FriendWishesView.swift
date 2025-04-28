//
//  FriendWishesView.swift
//  Wishy
//
//  Created by Karim Amsha on 1.05.2024.
//

import SwiftUI

struct FriendWishesView: View {
    @EnvironmentObject var appRouter: AppRouter
    let items = Array(1...2)

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .center, spacing: 8) {
                        AsyncImageView(width: 57, height: 57, cornerRadius: 8, imageURL: UserSettings.shared.user?.image?.toURL(), systemPlaceholder: "photo")
                        
                        Text("Ahmed M. Y. Al-Azaiza")
                            .customFont(weight: .bold, size: 14)
                            .foregroundColor(.white)
                        
                        HStack {
                            Text("2 قوائم علنية")
                            Image(systemName: "circle.fill")
                                .resizable().frame(width: 4, height: 4)
                            Text("2 قوائم خاصة")
                            Image(systemName: "circle.fill")
                                .resizable().frame(width: 4, height: 4)
                            Text("1 أمنية بنظام القَطَّة")
                            
                        }
                        .customFont(weight: .regular, size: 12)
                        .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(24)
                    .background(Color.primary().cornerRadius(4))
                    .padding(6)
                    .roundedBackground(cornerRadius: 4, strokeColor: .grayEBF0FF(), lineWidth: 1)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(LocalizedStringKey.specialCategories)
                            .customFont(weight: .bold, size: 16)
                            .foregroundColor(.primaryBlack())
                        
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 16)], spacing: 8) { // Reduced spacing to 8
                                ForEach(items, id: \.self) { index in
                                    VStack(spacing: 8) {
                                        LazyHGrid(rows: [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)], spacing: 8) {
                                            ForEach(0..<4, id: \.self) { _ in
                                                AsyncImageView(width: 65, height: 65, cornerRadius: 10, imageURL: URL(string: "https://example.com/image\(index).jpg"), systemPlaceholder: "photo")
                                                    .cornerRadius(4)
                                                    .padding(6)
                                            }
                                        }
                                        
                                        VStack {
                                            Text("Item \(index)")
                                                .customFont(weight: .bold, size: 14)
                                                .foregroundColor(.primaryBlack())
                                            
                                            Text("Item \(index)")
                                                .customFont(weight: .bold, size: 14)
                                                .foregroundColor(.primary())
                                        }
                                        .padding(.vertical, 4)
                                    }
                                    .roundedBackground(cornerRadius: 4, strokeColor: .grayEBF0FF(), lineWidth: 1)
                                    .onTapGesture {
                                        appRouter.navigate(to: .friendWishesListView)
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(LocalizedStringKey.retailSystem)
                            .customFont(weight: .bold, size: 16)
                            .foregroundColor(.primaryBlack())
                        
                        ScrollView(showsIndicators: false) {
                            ForEach(items, id: \.self) { index in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        AsyncImageView(width: 70, height: 70, cornerRadius: 5, imageURL: URL(string: ""), systemPlaceholder: "photo")
                                        
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("حذاء Nike")
                                                Spacer()
                                                Text("299,43 ر.س")
                                            }
                                            .customFont(weight: .bold, size: 16)
                                            .foregroundColor(.primaryBlack())
                                            
                                            HStack {
                                                Text("299,43 ر.س")
                                                Spacer()
                                                Text("17 مساهم")
                                            }
                                            .customFont(weight: .semiBold, size: 12)
                                            .foregroundColor(.primary())
                                            
                                            ProgressLineView(percentage: 75)
                                                .frame(height: 10)
                                            
                                        }
                                    }
                                    
                                    CustomDivider()
                                }
                                .onTapGesture {
                                    appRouter.navigate(to: .retailFriendWishesView)
                                }
                            }
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

                    Text(LocalizedStringKey.friendWishes)
                        .customFont(weight: .bold, size: 20)
                        .foregroundColor(Color.primaryBlack())
                }
            }
        }
    }
}

#Preview {
    FriendWishesView()
}
