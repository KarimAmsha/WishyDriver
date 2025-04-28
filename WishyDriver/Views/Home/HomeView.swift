//
//  HomeView.swift
//  Wishy
//
//  Created by Karim Amsha on 28.04.2024.
//

import SwiftUI
import FirebaseMessaging

struct HomeView: View {
    @EnvironmentObject var appRouter: AppRouter
    @StateObject private var viewModel = OrderViewModel(errorHandling: ErrorHandling())
    @StateObject private var initialViewModel = InitialViewModel(errorHandling: ErrorHandling())
    @StateObject private var userViewModel = UserViewModel(errorHandling: ErrorHandling())

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                GridView(orderStatistics: viewModel.orderStatistics)
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                VStack {
                    Text(LocalizedStringKey.home)
                        .customFont(weight: .bold, size: 20)
                      .foregroundColor(Color.black141F1F())
                }
            }
        }
        .onChange(of: viewModel.errorMessage) { errorMessage in
            if let errorMessage = errorMessage {
                appRouter.togglePopupError(.alertError("", errorMessage))
            }
        }
        .onChange(of: initialViewModel.errorMessage) { errorMessage in
            if let errorMessage = errorMessage {
                appRouter.togglePopupError(.alertError(LocalizedStringKey.error, errorMessage))
            }
        }
        .onAppear {
            viewModel.getOrderStatistics {
                //
            }
            refreshFcmToken()
        }
    }
}

#Preview {
    HomeView()
}

extension HomeView {
    func refreshFcmToken() {
        Messaging.messaging().token { token, error in
            if let error = error {
            } else if let token = token {
                let params: [String: Any] = [
                    "id": UserSettings.shared.id ?? "",
                    "fcmToken": token
                ]
                userViewModel.refreshFcmToken(params: params, onsuccess: {
                    
                })
            }
        }
    }
}
