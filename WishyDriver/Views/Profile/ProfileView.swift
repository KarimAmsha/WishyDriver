//
//  ProfileView.swift
//  Wishy
//
//  Created by Karim Amsha on 30.04.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appRouter: AppRouter
    @StateObject private var initialViewModel = InitialViewModel(errorHandling: ErrorHandling())
    @StateObject private var authViewModel = AuthViewModel(errorHandling: ErrorHandling())
    @StateObject private var userViewModel = UserViewModel(errorHandling: ErrorHandling())
    @EnvironmentObject var appState: AppState
    @State private var isToggleOn = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(alignment: .center, spacing: 8) {
                        AsyncImageView(
                            width: 57,
                            height: 57,
                            cornerRadius: 8,
                            imageURL: UserSettings.shared.user?.image?.toURL(),
                            placeholder: Image(systemName: "photo"),
                            contentMode: .fill
                        )

                        Text(UserSettings.shared.user?.fullName ?? "")
                            .customFont(weight: .bold, size: 14)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(24)
                    .background(Color.primary().cornerRadius(4))
                    .padding(6)
                    .roundedBackground(cornerRadius: 4, strokeColor: .grayEBF0FF(), lineWidth: 1)

                    VStack(spacing: 16) {
                        VStack(spacing: 0) {
                            HStack {
                                Image("ic_lock")

                                HStack {
                                    Text(LocalizedStringKey.isAvailabilityEnabled)
                                        .customFont(weight: .medium, size: 14)
                                        .foregroundColor(.primaryBlack())
                                    Spacer()
                                    Toggle("", isOn: $isToggleOn)
                                        .padding()
                                        .toggleStyle(CustomToggleStyle())
                                        .onChange(of: isToggleOn) { newValue in
                                            // Update the user's availability in settings and trigger a network request
                                            updateAvailability(newValue)
                                        }
                                }
                                
                                Spacer()
                            }
                            CustomDivider(color: .grayF2F2F2())
                        }
                        .padding(.leading, 14)

                        CustomListItem(title: LocalizedStringKey.notifications,
                                       subtitle: LocalizedStringKey.notifications,
                                       icon: Image("ic_b_bell"),
                                       action: {
                            appRouter.navigate(to: .notifications)
                        }) {
                        }
                        
                        CustomListItem(title: LocalizedStringKey.aboutApp,
                                       subtitle: LocalizedStringKey.aboutApp,
                                       icon: Image("ic_mobile"),
                                       action: {
                            if let item = initialViewModel.constantsItems?.filter({ $0.constantType == .about }).first {
                                appRouter.navigate(to: .constant(item))
                            }
                        }) {
                        }

                        CustomListItem(title: LocalizedStringKey.usePolicy,
                                       subtitle: LocalizedStringKey.usePolicy,
                                       icon: Image("ic_lock"),
                                       action: {
                            if let item = initialViewModel.constantsItems?.filter({ $0.constantType == .using }).first {
                                appRouter.navigate(to: .constant(item))
                            }
                        }) {
                        }

                        CustomListItem(title: LocalizedStringKey.privacyPolicy,
                                       subtitle: LocalizedStringKey.privacyPolicy,
                                       icon: Image("ic_lock"),
                                       action: {
                            if let item = initialViewModel.constantsItems?.filter({ $0.constantType == .privacy }).first {
                                appRouter.navigate(to: .constant(item))
                            } else {
                                if let item = initialViewModel.constantsItems?.filter({ $0.constantType == .privacy }).first {
                                    appRouter.navigate(to: .constant(item))
                                }
                            }
                        }) {
                        }
                        
                        CustomListItem(title: LocalizedStringKey.deleteAccount,
                                       subtitle: LocalizedStringKey.deleteAccountHint,
                                       icon: Image("ic_delete"),
                                       action: {
                            deleteAccount()
                        }, textColor: .dangerNormal()) {
                        }
                        
                        CustomListItem(title: LocalizedStringKey.logout,
                                       subtitle: LocalizedStringKey.logoutHint,
                                       icon: Image("ic_logout"),
                                       action: {
                            logout()
                        }, textColor: .dangerNormal()) {
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
//        .background(Color.background())
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Text(LocalizedStringKey.profile)
//                    .customFont(weight: .bold, size: 18)
//                    .foregroundColor(.primaryBlack())
//            }
//            
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    appRouter.navigate(to: .notifications)
//                } label: {
//                    Image("ic_bell")
//                }
//            }
//        }
        .onAppear {
            getConstants()
        }
    }
}

#Preview {
    ProfileView()
}

extension ProfileView {
    private func getConstants() {
        initialViewModel.fetchConstantsItems()
    }

    private func logout() {
        let alertModel = AlertModel(icon: "",
                                    title: LocalizedStringKey.logout,
                                    message: LocalizedStringKey.logoutMessage,
                                    hasItem: false,
                                    item: nil,
                                    okTitle: LocalizedStringKey.logout,
                                    cancelTitle: LocalizedStringKey.back,
                                    hidesIcon: true,
                                    hidesCancel: true) {
            authViewModel.logoutUser {
                appState.currentPage = .home
            }
            appRouter.dismissPopup()
        } onCancelAction: {
            appRouter.dismissPopup()
        }
        
        appRouter.togglePopup(.alert(alertModel))
    }
    
    private func deleteAccount() {
        let alertModel = AlertModel(icon: "",
                                    title: LocalizedStringKey.deleteAccount,
                                    message: LocalizedStringKey.deleteAccountMessage,
                                    hasItem: false,
                                    item: nil,
                                    okTitle: LocalizedStringKey.deleteAccount,
                                    cancelTitle: LocalizedStringKey.back,
                                    hidesIcon: true,
                                    hidesCancel: true) {
            authViewModel.deleteAccount {
                appState.currentPage = .home
            }
            appRouter.dismissPopup()
        } onCancelAction: {
            appRouter.dismissPopup()
        }
        
        appRouter.togglePopup(.alert(alertModel))
    }
}

extension ProfileView {
    private func updateAvailability(_ value: Bool) {
        let params: [String: Any] = [
            "isAvailable": value
        ]
        
        userViewModel.updateAvailability(params: params) { message in
            //
        }
    }
}
