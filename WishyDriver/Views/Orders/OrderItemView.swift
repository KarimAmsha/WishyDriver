//
//  OrderRowView.swift
//  WishyDriver
//
//  Created by Karim Amsha on 15.06.2024.
//

import SwiftUI

struct OrderRowView: View {
    
    var item: Order
    var showProviderDetailsAction: () -> Void
    var startOrder: (String) -> Void
    var cancelOrder: (String) -> Void
    var finishOrder: (String) -> Void

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                profileImageView()
                VStack(alignment: .leading) {
                    Text(item.user?.full_name ?? "")
                        .customFont(weight: .bold, size: 14)
                        .foregroundColor(.black0B0B0B())
                    Text(item.user?.phone_number ?? "")
                        .customFont(weight: .regular, size: 14)
                        .foregroundColor(.black0B0B0B())
                }
                Spacer()
                Text(item.orderStatus?.value ?? "")
                    .customFont(weight: .regular, size: 12)
                    .foregroundColor(item.orderStatus?.colors.foreground ?? .primary())
                    .padding(.vertical, 4)
                    .padding(.horizontal, 14)
                    .background(item.orderStatus?.colors.background ?? .clear)
                    .clipShape(Capsule())
            }
            
            VStack(alignment: .leading) {
                Text("\(item.subCategoryId?.arName ?? "") - \(item.categoryId?.arName ?? "")")
                    .customFont(weight: .bold, size: 14)
                    .foregroundColor(.black1C1C28())
                
                HStack(spacing: 20) {
                    HStack {
                        Image("ic_calendar")
                        Text(item.formattedCreatedDate ?? "")
                            .customFont(weight: .regular, size: 12)
                            .foregroundColor(.black0B0B0B())
                    }
                    HStack {
                        Image("ic_clock")
                        Text(item.dtTime ?? "")
                            .customFont(weight: .regular, size: 12)
                            .foregroundColor(.black0B0B0B())
                    }
                    Spacer()
                }
                
                HStack {
                    Image("ic_location")
                    Text(item.address?.address ?? "")
                        .customFont(weight: .regular, size: 12)
                        .foregroundColor(.black0B0B0B())
                    Spacer()
                }
            }
            
//            HStack(spacing: 16) {
//                if item.orderStatus == .accepted {
//                    // Start Order Button
//                    Button(action: {
//                        withAnimation {
//                            startOrder(item.id ?? "")
//                        }
//                    }) {
//                        Text(LocalizedStringKey.startOrder)
//                    }
//                    .buttonStyle(PrimaryButton(fontSize: 16, fontWeight: .bold, background: .green0C9D61(), foreground: .white, height: 48, radius: 8))
//
//                    // Cancel Order Button
//                    Button(action: {
//                        cancelOrder(item.id ?? "")
//                    }) {
//                        Text(LocalizedStringKey.cancelOrder)
//                    }
//                    .buttonStyle(PrimaryButton(fontSize: 16, fontWeight: .bold, background: .primary(), foreground: .black121212(), height: 48, radius: 8))
//                }
//
//                if item.orderStatus == .progress {
//                    // Finish Order Button
//                    Button(action: {
//                        finishOrder(item.id ?? "")
//                    }) {
//                        Text(LocalizedStringKey.finishOrder)
//                    }
//                    .buttonStyle(PrimaryButton(fontSize: 16, fontWeight: .regular, background: .orangeFCE5E5(), foreground: .redE50000(), height: 48, radius: 8))
//                }
//            }
//            .customFont(weight: .bold, size: 14)

            CustomDivider()
        }
        .padding(8)
    }
}

#Preview {
//    OrderRowView(item: Order(loc: nil, extra: nil, updateCode: nil, id: nil, lat: nil, lng: nil, price: nil, address: nil, orderNo: nil, tax: nil, total: nil, totalDiscount: nil, netTotal: nil, status: nil, createAt: nil, dtDate: nil, dtTime: nil, subCategoryId: nil, categoryId: nil, couponCode: nil, paymentType: nil, user: nil, notes: nil, canceledNote: nil, employee: nil, provider: nil, supervisor: nil, place: nil), showProviderDetailsAction: {}, startOrder: {id in}, cancelOrder: {id in}, finishOrder: {id in})
}

extension OrderRowView {
    @ViewBuilder
    func profileImageView() -> some View {
        if let imageURL = item.user?.image?.toURL() {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .tint(Color.primary())
                case .success(let image):
                    loadedImage(image)
                case .failure:
                    placeholderImage
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 56, height: 56)
            .cornerRadius(8)
        } else {
            placeholderImage
        }
    }

    private var placeholderImage: some View {
        Image("ic_logo")
            .resizable()
            .imageScale(.large)
            .foregroundColor(.gray)
            .frame(width: 56, height: 56)
            .cornerRadius(8)
    }

    private func loadedImage(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 56, height: 56)
            .cornerRadius(8)
    }
}
