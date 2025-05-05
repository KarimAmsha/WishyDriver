//
//  OrdersView.swift
//  Wishy
//
//  Created by Karim Amsha on 30.04.2024.
//

import SwiftUI

struct OrdersView: View {
    @State var orderType: OrderStatus = .accepted
    @StateObject private var orderViewModel = OrderViewModel(errorHandling: ErrorHandling())
    @State private var searchText: String = ""
    @EnvironmentObject var appRouter: AppRouter

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                SearchBar(text: $searchText)

                OrderTypeScrollView(orderType: $orderType)
                    .padding()
                
                ScrollView(showsIndicators: false) {
                    if orderViewModel.orders.isEmpty {
                        DefaultEmptyView(title: LocalizedStringKey.noOrdersFound)
                    } else {
                        let orders = orderViewModel.orders
                        ForEach(orders.indices, id: \.self) { index in
                            let item = orders[index]
                            OrderItemView(item: item, onSelect: {
                                appRouter.navigate(to: .orderDetails(item.id ?? ""))
                            })
                        }
                    }
                    
                    if orderViewModel.shouldLoadMoreData {
                        Color.clear.onAppear {
                            loadMore()
                        }
                    }
                    
                    if orderViewModel.isFetchingMoreData {
                        LoadingView()
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 24)
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationTitle("")
        .background(Color.grayF9F9F9())
        .dismissKeyboardOnTap()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                VStack {
                    Text(LocalizedStringKey.orders)
                        .customFont(weight: .bold, size: 20)
                      .foregroundColor(Color.black141F1F())
                }
            }
        }
        .onAppear {
            loadData()
        }
        .onChange(of: orderViewModel.errorMessage) { errorMessage in
            if let errorMessage = errorMessage {
                appRouter.togglePopupError(.alertError("", errorMessage))
            }
        }
        .onChange(of: orderType) { type in
            loadData()
        }
        .onChange(of: searchText) { newSearchText in
            loadData(orderNo: newSearchText)
        }
    }
}

#Preview {
    OrdersView()
}

extension OrdersView {
    func loadData(orderNo: String = "") {
        orderViewModel.orders.removeAll()
        let params: [String: Any] = [
            "status": orderType.rawValue,
            "order_no": orderNo
        ]
        orderViewModel.getOrders(page: 0, limit: 10, params: params)
    }
    
    func loadMore() {
        let params: [String: Any] = [
            "status": orderType.rawValue,
            "order_no": ""
        ]
        orderViewModel.loadMoreOrders(limit: 10, params: params)
    }
}

extension OrdersView {
    private func updateOrderStatus(orderID: String, status: OrderStatus, canceledNote: String = "") {
        let params: [String: Any] = [
            "status": status.rawValue,
            "canceled_note": canceledNote
        ]
        
        orderViewModel.updateOrderStatus(orderId: orderID, params: params, onsuccess: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                loadData()
            })
        })
    }
    
    private func presentCancellationReasonPopup(orderID: String, status: OrderStatus) {
        let alertModel = AlertModelWithInput(
            title: LocalizedStringKey.logout,
            content: LocalizedStringKey.description,
            hideCancelButton: false,
            onOKAction: { content in
                updateOrderStatus(orderID: orderID, status: status, canceledNote: content)
                appRouter.togglePopup(nil)
            },
            onCancelAction: {
                withAnimation {
                    appRouter.togglePopup(nil)
                }
            }
        )
        
        appRouter.togglePopup(.inputAlert(alertModel))
    }
}

struct OrderTypeButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            Text(title)
                .customFont(weight: isSelected ? .bold : .regular, size: 12)
        }
        .buttonStyle(PrimaryButton(
            fontSize: 12,
            fontWeight: .bold,
            background: isSelected ? .primary1() : .white,
            foreground: isSelected ? .white : .black121212(),
            height: 40,
            radius: 8
        ))
    }
}

struct OrderTypeScrollView: View {
    @Binding var orderType: OrderStatus

    let orderTypes: [(OrderStatus, String)] = [
        (.accepted, LocalizedStringKey.accepted),
        (.started, LocalizedStringKey.started),
        (.way, LocalizedStringKey.way),
        (.progress, LocalizedStringKey.progress),
        (.updated, LocalizedStringKey.updated),
        (.prefinished, LocalizedStringKey.unconfirmed),
        (.finished, LocalizedStringKey.finished),
        (.canceled, LocalizedStringKey.canceled)
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(orderTypes, id: \.0) { type, title in
                    OrderTypeButton(
                        title: title,
                        isSelected: orderType == type,
                        action: {
                            orderType = type
                        }
                    )
                }
            }
            .padding(4)
            .frame(height: 60)
        }
    }
}
