//
//  OrdersView.swift
//  Wishy
//
//  Created by Karim Amsha on 30.04.2024.
//

import SwiftUI

struct OrdersView: View {
    @StateObject private var router: MainRouter
    @State var orderType: OrderStatus = .accepted
    @StateObject private var orderViewModel = OrderViewModel(errorHandling: ErrorHandling())
    @State private var searchText: String = ""

    init(router: MainRouter) {
        _router = StateObject(wrappedValue: router)
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                SearchBar(text: $searchText)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        Button {
                            withAnimation {
                                orderType = .accepted
                            }
                        } label: {
                            Text(LocalizedStringKey.accepted)
                                .customFont(weight: orderType == .accepted ? .bold : .regular, size: 12)
                                .foregroundColor(orderType == .accepted ? .white : .black121212())
                        }
                        .buttonStyle(PrimaryButton(fontSize: 12, fontWeight: .bold, background: orderType == .accepted ? .blue068DA9() : .white, foreground: .black121212(), height: 40, radius: 8))

                        Button {
                            withAnimation {
                                orderType = .started
                            }
                        } label: {
                            Text(LocalizedStringKey.started)
                                .customFont(weight: orderType == .started ? .bold : .regular, size: 12)
                                .foregroundColor(orderType == .started ? .white : .black121212())
                        }
                        .buttonStyle(PrimaryButton(fontSize: 12, fontWeight: .bold, background: orderType == .started ? .blue068DA9() : .white, foreground: .black121212(), height: 40, radius: 8))

                        Button {
                            withAnimation {
                                orderType = .way
                            }
                        } label: {
                            Text(LocalizedStringKey.way)
                                .customFont(weight: orderType == .way ? .bold : .regular, size: 12)
                                .foregroundColor(orderType == .way ? .white : .black121212())
                        }
                        .buttonStyle(PrimaryButton(fontSize: 12, fontWeight: .bold, background: orderType == .way ? .blue068DA9() : .white, foreground: .black121212(), height: 40, radius: 8))

                        Button {
                            withAnimation {
                                orderType = .progress
                            }
                        } label: {
                            Text(LocalizedStringKey.progress)
                                .customFont(weight: orderType == .progress ? .bold : .regular, size: 12)
                                .foregroundColor(orderType == .progress ? .white : .black121212())
                        }
                        .buttonStyle(PrimaryButton(fontSize: 12, fontWeight: .bold, background: orderType == .progress ? .blue068DA9() : .white, foreground: .black121212(), height: 40, radius: 8))

                        Button {
                            withAnimation {
                                orderType = .updated
                            }
                        } label: {
                            Text(LocalizedStringKey.updated)
                                .customFont(weight: orderType == .updated ? .bold : .regular, size: 12)
                                .foregroundColor(orderType == .updated ? .white : .black121212())
                        }
                        .buttonStyle(PrimaryButton(fontSize: 12, fontWeight: .bold, background: orderType == .updated ? .blue068DA9() : .white, foreground: .black121212(), height: 40, radius: 8))

                        Button {
                            withAnimation {
                                orderType = .prefinished
                            }
                        } label: {
                            Text(LocalizedStringKey.unconfirmed)
                                .customFont(weight: orderType == .prefinished ? .bold : .regular, size: 12)
                                .foregroundColor(orderType == .prefinished ? .white : .black121212())
                        }
                        .buttonStyle(PrimaryButton(fontSize: 12, fontWeight: .bold, background: orderType == .prefinished ? .blue068DA9() : .white, foreground: .black121212(), height: 40, radius: 8))

                        Button {
                            withAnimation {
                                orderType = .finished
                            }
                        } label: {
                            Text(LocalizedStringKey.finished)
                                .customFont(weight: orderType == .finished ? .bold : .regular, size: 12)
                                .foregroundColor(orderType == .finished ? .white : .black121212())
                        }
                        .buttonStyle(PrimaryButton(fontSize: 12, fontWeight: .bold, background: orderType == .finished ? .blue068DA9() : .white, foreground: .black121212(), height: 40, radius: 8))

                        Button {
                            withAnimation {
                                orderType = .canceled
                            }
                        } label: {
                            Text(LocalizedStringKey.canceled)
                                .customFont(weight: orderType == .canceled ? .bold : .regular, size: 12)
                                .foregroundColor(orderType == .canceled ? .white : .black121212())
                        }
                        .buttonStyle(PrimaryButton(fontSize: 12, fontWeight: .bold, background: orderType == .canceled ? .blue068DA9() : .white, foreground: .black121212(), height: 40, radius: 8))
                    }
                }
                .padding(4)
                .frame(height: 60)
                
                if orderViewModel.isFetchingMoreData {
                    LoadingView()
                }

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        if orderViewModel.orders.isEmpty {
                            Text(LocalizedStringKey.noOrdersFound)
                                .customFont(weight: .bold, size: 14)
                                .foregroundColor(.black121212())
                                .padding()
                        } else {
                            ForEach(orderViewModel.orders, id: \.self) { item in
                                OrderRowView(item: item, showProviderDetailsAction: {
                                    router.presentViewSpec(viewSpec: .providerDetails)
                                }, startOrder: {id in
                                    updateOrderStatus(orderID: id, status: .started)
                                }, cancelOrder: {id in
                                    presentCancellationReasonPopup(orderID: id, status: .canceled)
                                }, finishOrder: {id in
                                    updateOrderStatus(orderID: id, status: .prefinished)
                                })
                                .onTapGesture {
                                    router.presentOrderDetail(orderID: item.id ?? "")
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
                        }
                    }
                    .background(Color.white.cornerRadius(8))
                }
            }
            .padding(.horizontal, 24)
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationTitle("")
        .background(Color.grayF9F9F9())
        .dismissKeyboard()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                VStack {
                    Text(LocalizedStringKey.lastOrders)
                        .customFont(weight: .bold, size: 20)
                      .foregroundColor(Color.black141F1F())
                }
            }
        }
        .onAppear {
            loadData()
            
            // Start observing changes for all orders when the view appears
            orderViewModel.observeAllOrdersChanges { (orderDetail) in
                print("iiii \(orderDetail)")
//                if let index = orderViewModel.orders.firstIndex(where: { $0.id == orderDetail?.orderId }) {
                    self.loadData()
                if let status = orderDetail.order.status {
                    print("22222 \(orderDetail)")
                    if let orderStatus = OrderStatus(rawValue: status) {
                        self.orderType = orderStatus
                    }
                }

//                }
            }
        }
//        .onDisappear {
//            // Stop observing changes when the view disappears
//            // Note: This will stop observing for all views using the same observer
//            // If you want to keep observing changes in other views, you may not want to stop it here
//            Constants.ordersRef.removeAllObservers()
//        }
        .onChange(of: orderViewModel.errorMessage) { errorMessage in
            if let errorMessage = errorMessage {
                router.presentToastPopup(view: .error("", errorMessage))
            }
        }
        .onChange(of: orderType) { type in
            loadData()
        }
        .onChange(of: searchText) { newSearchText in
            loadData(orderNo: newSearchText)
        }
//        .onReceive(orderViewModel.$fbOrder, perform: { item in
//            if let item = item, let status = item.order.status {
//                print("iiiiii \(item)")
//                if let orderStatus = OrderStatus(rawValue: status) {
//                    self.orderType = orderStatus
//                }
//            }
//        })
    }
    
    private func calculateButtonWidth(for text: String) -> CGFloat {
        let buttonWidth = text.widthOfString(usingFont: UIFont.systemFont(ofSize: 12)) + 32
        return max(buttonWidth, 110)
    }
}

#Preview {
    OrdersView(router: MainRouter(isPresented: .constant(.main)))
}

extension OrdersView {
    func loadData(orderNo: String = "") {
        orderViewModel.orders.removeAll()
        let params: [String: Any] = [
            "status": orderType.rawValue,
            "order_no": orderNo
        ]
        orderViewModel.getOrders(StatusId: 2, page: 0, limit: 10, params: params)
    }
    
    func loadMore() {
        let params: [String: Any] = [
            "status": orderType.rawValue,
            "order_no": ""
        ]
        orderViewModel.loadMoreOrders(StatusId: 2, limit: 10, params: params)
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField(LocalizedStringKey.search, text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            if !text.isEmpty {
                Button(action: {
                    withAnimation {
                        text = ""
                    }
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                        .padding(8)
                }
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.top, 16)
    }
}

extension OrdersView {
    private func updateOrderStatus(orderID: String, status: OrderStatus, canceledNote: String = "", extraItems: [String] = []) {
        let params: [String: Any] = [
            "status": status.rawValue,
            "canceled_note": canceledNote,
            "extra": extraItems
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
                router.dismiss()
            },
            onCancelAction: {
                router.dismiss()
            }
        )
        
        router.presentToastPopup(view: .inputAlert(alertModel))
    }
}
