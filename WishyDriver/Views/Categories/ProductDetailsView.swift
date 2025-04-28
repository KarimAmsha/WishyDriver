//
//  ProductDetailsView.swift
//  Wishy
//
//  Created by Karim Amsha on 1.05.2024.
//

import SwiftUI

struct ProductDetailsView: View {
    @EnvironmentObject var appRouter: AppRouter

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
//                    AsyncImageView(width: UIScreen.main.bounds.size.width, height: 250, cornerRadius: 10, imageURL: URL(string: "https://media.zid.store/cdn-cgi/image/f=auto/https://media.zid.store/ca6f01a7-f802-4c28-b793-b6c642a7f178/42610e71-37fa-471e-aa72-b5e11fb658a7.jpg"), systemPlaceholder: "photo")

                    VStack(alignment: .leading, spacing: 12) {
                        Text("سلة ورد")
                            .customFont(weight: .bold, size: 16)
                            .foregroundColor(.primaryBlack())

                        HStack {
                            Text("299,43 ر.س")
                                .customFont(weight: .semiBold, size: 14)
                                .foregroundColor(.primary())
                            
                            Spacer()
                            
                            RatingView(rating: .constant(3))
                        }
                        
                        Text("باقة سلة ورد من أفضل أنواع الورد الجوري. صممنا لك باقة سلة ورد من ورد جوري احمر رومانسي بعناية فائقة لتجمع بين روعة الورد الجوري الأحمر الكبير وسحر البوكس الورقي الأسود الرائع. تحاكي الباقة مظهر الورود وكأنها تخرج من سلة ورد، مما يضفي عليها لمسة فريدة وراقية.")
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
                    appRouter.navigate(to: .selectedGiftView)
                } label: {
                    HStack(spacing: 4) {
                        Image("ic_w_gift")
                        Text(LocalizedStringKey.sendGiftNow)
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

                    Text("سلة ورد")
                        .customFont(weight: .bold, size: 20)
                        .foregroundColor(Color.primaryBlack())
                }
            }
        }
    }
}

#Preview {
    ProductDetailsView()
}
