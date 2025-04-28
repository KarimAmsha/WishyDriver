//
//  NotificationsView.swift
//  WishyDriver
//
//  Created by Karim Amsha on 16.06.2024.
//

import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var settings: UserSettings
    @StateObject private var viewModel = NotificationsViewModel(errorHandling: ErrorHandling())
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    if viewModel.notificationsItems.isEmpty {
                        DefaultEmptyView(title: LocalizedStringKey.noDataFound)
                    } else {
                        ForEach(viewModel.notificationsItems, id: \.self) { item in
                            NotificationRowView(notification: item)
                                .onTapGesture {
                                    if item.notificationType == .orders {
                                        appRouter.navigate(to: .orderDetails(item.bodyParams ?? ""))
                                    }
                                }
                                .contextMenu {
                                    Button(action: {
                                        // Handle deletion here
                                        deleteNotification(item)
                                    }) {
                                        Text(LocalizedStringKey.delete)
                                            .font(.system(size: 14, weight: .regular, design: .default)) // Adjust the size and weight as needed
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                        
                        if viewModel.shouldLoadMoreData {
                            Color.clear.onAppear {
                                loadMore()
                            }
                        }
                        
                        if viewModel.isFetchingMoreData {
                            LoadingView()
                        }
                    }
                }
            }

            Spacer()
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

                    Text(LocalizedStringKey.notifications)
                        .customFont(weight: .bold, size: 20)
                        .foregroundColor(Color.primaryBlack())
                }
            }
        }
        .onAppear {
            loadData()
        }
        .onChange(of: viewModel.errorMessage) { errorMessage in
            if let errorMessage = errorMessage {
                appRouter.togglePopupError(.alertError("", errorMessage))
            }
        }
    }
}

#Preview {
    NotificationsView()
}

extension NotificationsView {
    func loadData() {
        viewModel.notificationsItems.removeAll()
        viewModel.fetchNotificationsItems(page: 0, limit: 10)
    }
    
    func loadMore() {
        viewModel.loadMoreNotifications(limit: 10)
    }
    
    func deleteNotification(_ notification: NotificationItem) {
        let alertModel = AlertModel(
            icon: "",
            title: LocalizedStringKey.delete,
            message: LocalizedStringKey.deleteMessage,
            hasItem: false,
            item: "",
            okTitle: LocalizedStringKey.ok,
            cancelTitle: "",
            hidesIcon: true,
            hidesCancel: true,
            onOKAction: {
                appRouter.togglePopup(nil)
                viewModel.deleteNotifications(id: notification.id ?? "") { message in
                    loadData()
                }
            },
            onCancelAction: {
                withAnimation {
                    appRouter.togglePopup(nil)
                }
            }
        )

        appRouter.togglePopup(.alert(alertModel))
    }
}

