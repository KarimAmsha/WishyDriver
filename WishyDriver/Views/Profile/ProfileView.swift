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
    @EnvironmentObject var appState: AppState

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(alignment: .center, spacing: 8) {
                        AsyncImageView(width: 57, height: 57, cornerRadius: 8, imageURL: UserSettings.shared.user?.image?.toURL(), systemPlaceholder: "photo")
                        
                        Text(UserSettings.shared.user?.full_name ?? "")
                            .customFont(weight: .bold, size: 14)
                            .foregroundColor(.white)
                        
                        HStack {
                            Text("2 قوائم علنية")
                            Image(systemName: "circle.fill")
                                .resizable().frame(width: 4, height: 4)
                            Text("2 قوائم خاصة")
                            Image(systemName: "circle.fill")
                                .resizable().frame(width: 4, height: 4)
                            Text("1 أمنية بنظام القَطَّة")

                        }
                        .customFont(weight: .regular, size: 12)
                        .foregroundColor(.white)
                        
                        HStack {
                            Button {
                                appRouter.navigate(to: .editProfile)
                            } label: {
                                Text(LocalizedStringKey.editMyProfile)
                            }
                            .buttonStyle(PrimaryButton(fontSize: 12, fontWeight: .semiBold, background: .primaryLight(), foreground: .primaryBlack(), height: 34, radius: 4))

                            Button {
                                //
                            } label: {
                                Image("ic_enter")
                                    .padding(8)
                                    .background(Color.primaryNormal().cornerRadius(4))
                            }

                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(24)
                    .background(Color.primary().cornerRadius(4))
                    .padding(6)
                    .roundedBackground(cornerRadius: 4, strokeColor: .grayEBF0FF(), lineWidth: 1)

                    VStack(spacing: 16) {
                        CustomListItem(title: LocalizedStringKey.eventReminders,
                                       subtitle: LocalizedStringKey.eventReminders,
                                       icon: Image("ic_calendar"),
                                       action: {
                            appRouter.navigate(to: .upcomingReminders)
                        }) {
                        }
                        
                        CustomListItem(title: LocalizedStringKey.myOrders,
                                       subtitle: LocalizedStringKey.myOrders,
                                       icon: Image("ic_orders"),
                                       action: {
                            appRouter.navigate(to: .myOrders)
                        }) {
                        }

                        CustomListItem(title: LocalizedStringKey.notifications,
                                       subtitle: LocalizedStringKey.notifications,
                                       icon: Image("ic_b_bell"),
                                       action: {
                            appRouter.navigate(to: .editProfile)
                        }) {
                        }

                        CustomListItem(title: LocalizedStringKey.aboutApp,
                                       subtitle: LocalizedStringKey.aboutApp,
                                       icon: Image("ic_mobile"),
                                       action: {
                            if let item = initialViewModel.constantsItems?.filter({ $0.constantType == .about }).first {
                                appRouter.navigate(to: .constant(item))
                            } else {
                                let item = ConstantItem(_id: "", Type: "about", Title: LocalizedStringKey.aboutApp, Content: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.")
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
                            } else {
                                let item = ConstantItem(_id: "", Type: "using", Title: LocalizedStringKey.usePolicy, Content: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.")
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
                                let item = ConstantItem(_id: "", Type: "privacy", Title: LocalizedStringKey.privacyPolicy, Content: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.")
                                appRouter.navigate(to: .constant(item))
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
        .background(Color.background())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(LocalizedStringKey.profile)
                    .customFont(weight: .bold, size: 20)
                    .foregroundColor(Color.primaryBlack())
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Image("ic_bell")
            }
        }
    }
}

#Preview {
    ProfileView()
}

extension ProfileView {
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

