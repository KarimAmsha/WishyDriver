//
//  RetailFriendWishesView.swift
//  Wishy
//
//  Created by Karim Amsha on 1.05.2024.
//

import SwiftUI

struct RetailFriendWishesView: View {
    @EnvironmentObject var appRouter: AppRouter

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    AsyncImageView(width: UIScreen.main.bounds.size.width, height: 250, cornerRadius: 10, imageURL: URL(string: "https://cdn.salla.sa/YaWlZ/Vt48yYEdfs50TZzKSjZC48F2cXqdNQTqmKUDzEaw.jpg"), systemPlaceholder: "photo")

                    VStack(alignment: .leading, spacing: 12) {
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

                        Text("يجمع حذاء Nike Air Max 270 React ENG بين النعل الأوسط من إسفنج React كامل الطول ووحدة 270 Max Air لراحة لا مثيل لها وتجربة بصرية مذهلة.")
                            .customFont(weight: .regular, size: 14)
                            .foregroundColor(.primaryBlack())
                    }
                    .padding(.horizontal, 16)
                }
            }
            
            Spacer()
            
            VStack {
                CustomDivider()
                Button {
                    appRouter.navigate(to: .retailPaymentView)
                } label: {
                    HStack(spacing: 4) {
                        Image("ic_w_gift")
                        Text("ساهم بقطّة منك لتحقيق أمنية!")
                    }
                }
                .buttonStyle(GradientPrimaryButton(fontSize: 16, fontWeight: .bold, background: Color.primaryGradientColor(), foreground: .white, height: 48, radius: 12))
                .padding(.horizontal, 16)
            }
        }
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

                    Text("Nike Air Zoom Pegasus 36 Miami")
                        .customFont(weight: .bold, size: 20)
                        .foregroundColor(Color.primaryBlack())
                }
            }
        }
    }
}

#Preview {
    RetailFriendWishesView()
}
