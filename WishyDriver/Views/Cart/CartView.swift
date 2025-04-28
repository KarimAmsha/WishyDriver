//
//  CartView.swift
//  Wishy
//
//  Created by Karim Amsha on 30.04.2024.
//

import SwiftUI

struct CartView: View {
    let items = Array(1...5)
    @State private var quantities: [Int] = Array(repeating: 1, count: 10)
    @State private var quantity: Int = 1
    @State var selectedItems: [String] = Array(repeating: "", count: 10)
    @EnvironmentObject var appRouter: AppRouter

    var isSelected: Bool {
        selectedItems.contains { $0 == "" }
    }

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(items, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            AsyncImageView(width: 60, height: 60, cornerRadius: 5, imageURL: "https://cdn.salla.sa/wQYpe/4kqoxHKsNU0dbsA612HutA1MheJtnVuLzYAThADg.jpg".toURL(), systemPlaceholder: "photo")
                            
                            VStack(alignment: .leading) {
                                Text("سلة ورد")
                                    .customFont(weight: .bold, size: 14)
                                    .foregroundColor(.primaryBlack())

                                Text("\(quantities[index-1]) قوائم")
                                    .customFont(weight: .semiBold, size: 12)
                                    .foregroundColor(.primary())
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Button(action: {
                                    if isSelected {
                                        quantity += 1
                                        updateSelectedServiceQuantity()
                                    } else {
                                        toggleSelectedState()
                                    }
                                }) {
                                    Image(systemName: "plus")
                                }

                                Text("\(quantity)")
                                    .padding(.horizontal, 8)
                                    
                                Button(action: {
                                    if isSelected && quantity > 1 {
                                        quantity -= 1
                                        updateSelectedServiceQuantity()
                                    } else {
                                        toggleSelectedState()
                                    }
                                }) {
                                    Image(systemName: "minus")
                                }
                            }
                            .padding(4)
                            .customFont(weight: .semiBold, size: 12)
                            .foregroundColor(Color.primary())
                            .background(Color.primaryLight().cornerRadius(4))
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                HStack {
                    Text(LocalizedStringKey.total)
                    Spacer()
                    HStack {
                        Text("2096")
                        Text(LocalizedStringKey.sar)
                    }
                }
                .customFont(weight: .bold, size: 14)
                .padding(.horizontal, 10)
                .padding(.vertical, 14)
                .foregroundColor(.primaryBlack())
                .background(Color.grayEBF0FF().cornerRadius(4))
                .roundedBackground(cornerRadius: 4, strokeColor: .grayD8E2FF(), lineWidth: 1)

                Button {
                    appRouter.navigate(to: .paymentSuccess)
                } label: {
                    Text(LocalizedStringKey.completeYourPurchaseNow)
                }
                .buttonStyle(GradientPrimaryButton(fontSize: 16, fontWeight: .bold, background: Color.primaryGradientColor(), foreground: .white, height: 48, radius: 12))

            }
        }
        .padding(16)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(LocalizedStringKey.cart)
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
    
    func toggleSelectedState() {
        if let index = selectedItems.firstIndex(where: { $0 == "" }) {
            selectedItems.remove(at: index)
        } else {
            // Append some value to selectedItems
            selectedItems.append("someValue")
        }
    }

    func updateSelectedServiceQuantity() {
        // Update selected service quantity
    }
}

#Preview {
    CartView()
}
