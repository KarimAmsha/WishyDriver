//
//  OrderDetailsView.swift
//  Wishy
//
//  Created by Karim Amsha on 30.04.2024.
//

import SwiftUI

struct OrderDetailsView: View {
    let items = Array(1...5)
    @State private var quantities: [Int] = Array(repeating: 1, count: 10)
    @State private var quantity: Int = 1
    @State var selectedItems: [String] = Array(repeating: "", count: 10)
    @EnvironmentObject var appRouter: AppRouter
    @State private var orderStatus: OrderStatus = .accepted

    var isSelected: Bool {
        selectedItems.contains { $0 == "" }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                HStack {
                    AsyncImageView(width: 60, height: 60, cornerRadius: 5, imageURL: URL(string: ""), systemPlaceholder: "photo")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("اكسسوار اليد الفضي، شنطة ظهر، شنطة يد")
                            .customFont(weight: .bold, size: 14)
                            .foregroundColor(.primaryBlack())

                        HStack {
                            Text("تاريخ الطلب: 25 مارس 2024")
                                .customFont(weight: .regular, size: 12)
                                .foregroundColor(.primaryBlack())
                            
                            Spacer()
                            
                            Text("قيد المراجعة")
                                .customFont(weight: .regular, size: 12)
                                .foregroundColor(.orangeF7941D())
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.orangeF7941D().opacity(0.2).clipShape(Capsule()))
                        }
                    }
                }
                .padding(.vertical, 8)

                CustomDivider()
                
                HStack {
                    VStack(alignment: .leading, spacing: -2) {
                        HStack {
                            Image("ic_circle_fill")
                            VStack(alignment: .leading) {
                                Text("تم استلام الطلب")
                                Text("لقد تم استلام طلبك بتاريخ 25 مارس 2024")
                            }
                            .customFont(weight: .bold, size: 12)
                            .foregroundColor(colorText(forOrderStatuses: [.accepted, .started, .way, .progress, .updated, .prefinished, .finished], currentStatus: orderStatus))
                        }
                        
                        Image("ic_line")
                            .resizable()
                            .frame(width: 5, height: 40)
                            .foregroundColor(color(forOrderStatuses: [.started, .way, .progress, .updated, .prefinished, .finished], currentStatus: orderStatus))
                            .padding(.leading, 13)

                        HStack {
                            Image("ic_circle")
                            VStack(alignment: .leading) {
                                Text("تم تأكيد طلبك")
                                Text("لقد تم بتأكيد طلبك طلبك بتاريخ ---")
                            }
                            .customFont(weight: .bold, size: 12)
                            .foregroundColor(colorText(forOrderStatuses: [.started, .way, .progress, .updated, .prefinished, .finished], currentStatus: orderStatus))
                        }

                        Image("ic_line")
                            .resizable()
                            .frame(width: 5, height: 40)
                            .foregroundColor(color(forOrderStatuses: [.way, .progress, .updated, .prefinished, .finished], currentStatus: orderStatus))
                            .padding(.leading, 13)

                        HStack {
                            Image("ic_circle")
                            VStack(alignment: .leading) {
                                Text("خرج للتوصيل")
                                Text("لقد خرج طلبك للتوصيل بتاريخ ---")
                            }
                            .customFont(weight: .bold, size: 12)
                            .foregroundColor(colorText(forOrderStatuses: [.progress, .updated, .prefinished, .finished], currentStatus: orderStatus))
                        }

                        Image("ic_line")
                            .resizable()
                            .frame(width: 5, height: 40)
                            .foregroundColor(color(forOrderStatuses: [.progress, .prefinished, .finished], currentStatus: orderStatus))
                            .padding(.leading, 13)

                        HStack {
                            Image("ic_circle")
                            VStack(alignment: .leading) {
                                Text("تم التسليم بنجاح!")
                                Text("لقم تم تسليم طلبك بنجاح بتاريخ ---")
                            }
                            .customFont(weight: .bold, size: 12)
                            .foregroundColor(colorText(forOrderStatuses: [.prefinished, .finished], currentStatus: orderStatus))
                        }
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    CustomDivider()
                    
                    HStack {
                        HStack(spacing: 16) {
//                            if viewModel.order?.orderStatus == .new || viewModel.order?.orderStatus == .accepted {
                                // Cancel Order Button
                                Button(action: {
//                                    presentCancellationReasonPopup(status: .canceled)
                                }) {
                                    Text(LocalizedStringKey.cancelOrder)
                                }
                                .buttonStyle(PrimaryButton(fontSize: 16, fontWeight: .bold, background: .redFAE8E8(), foreground: .redCA1616(), height: 48, radius: 8))
//                            }

//                            if viewModel.order?.orderStatus == .finished {
//                                // Review Order Button
//                                Button(action: {
//                                    if let order = viewModel.order {
//                                        router.presentViewSpec(viewSpec: .providerReview(order))
//                                    }
//                                }) {
//                                    Text(LocalizedStringKey.serviceReview)
//                                }
//                                .buttonStyle(PrimaryButton(fontSize: 16, fontWeight: .bold, background: .green0C9D61(), foreground: .white, height: 48, radius: 8))
//                            }
                        }
                        .customFont(weight: .bold, size: 14)
                    }
                    .padding(24)
                    .background(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .shadow(color: .black.opacity(0.07), radius: 12, x: 0, y: -3)
                    )
                }
//                .opacity(viewModel.order?.orderStatus == .new || viewModel.order?.orderStatus == .accepted || viewModel.order?.orderStatus == .updated || viewModel.order?.orderStatus == .finished ? 1 : 0)

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

                    Text(LocalizedStringKey.orderDetails)
                        .customFont(weight: .bold, size: 20)
                        .foregroundColor(Color.primaryBlack())
                }
            }
        }
    }
    
    func color(forOrderStatuses targetStatuses: [OrderStatus], currentStatus: OrderStatus) -> Color {
        return targetStatuses.contains(currentStatus) ? .orangeD67200() : .grayD2D2D2()
    }
    
    func imageColor(forOrderStatuses targetStatuses: [OrderStatus], currentStatus: OrderStatus) -> Color {
        return targetStatuses.contains(currentStatus) ? .orangeD67200() : .grayA5A5A5()
    }

    func colorText(forOrderStatuses targetStatuses: [OrderStatus], currentStatus: OrderStatus) -> Color {
        return targetStatuses.contains(currentStatus) ? .black1C1C28() : .grayA5A5A5()
    }
}

#Preview {
    OrderDetailsView()
}

