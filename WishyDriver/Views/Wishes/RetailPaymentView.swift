//
//  RetailPaymentView.swift
//  Wishy
//
//  Created by Karim Amsha on 1.05.2024.
//

import SwiftUI

struct RetailPaymentView: View {
    @EnvironmentObject var appRouter: AppRouter
    @State var price = ""
    
    var body: some View {
        VStack {
            Image("ic_money")
                .padding(.top, 80)
            
            Text("اكتب القيمة بالريال السعودي")
                .customFont(weight: .bold, size: 16)
                .foregroundColor(.primaryBlack())
            
            VStack(alignment: .leading) {
                TextField(LocalizedStringKey.sar, text: $price)
                    .placeholder(when: price.isEmpty) {
                        Text(LocalizedStringKey.sar)
                            .foregroundColor(.gray999999())
                    }
                    .customFont(weight: .regular, size: 14)
                    .keyboardType(.numberPad)
                    .accentColor(.primary())
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                    .underline()
                    .roundedBackground(cornerRadius: 12, strokeColor: .gray898989(), lineWidth: 1)
            }
            .foregroundColor(.black222020())

            Spacer()
            
            Button {
                appRouter.navigate(to: .paymentSuccess)
            } label: {
                Text("الاستمرار للدفع")
            }
            .buttonStyle(GradientPrimaryButton(fontSize: 16, fontWeight: .bold, background: Color.primaryGradientColor(), foreground: .white, height: 48, radius: 12))
            .padding(.horizontal, 16)
        }
        .padding(16)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button {
                        appRouter.navigateBack()
                    } label: {
                        Image("ic_back")
                    }

                    Text("ساهم الان بـ قَطّة!")
                        .customFont(weight: .bold, size: 20)
                        .foregroundColor(Color.primaryBlack())
                }
            }
        }
    }
}

#Preview {
    RetailPaymentView()
}
