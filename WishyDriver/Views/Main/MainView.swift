//
//  MainView.swift
//  Wishy
//
//  Created by Karim Amsha on 27.04.2024.
//

import SwiftUI
import PopupView

struct MainView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var settings: UserSettings
    @State var showAddOrder = false
    @State private var path = NavigationPath()
    @ObservedObject var appRouter = AppRouter()

    var body: some View {
        NavigationStack(path: $appRouter.navPath) {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.clear)
                    .background(.white)

                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        Spacer()
                        switch appState.currentPage {
                        case .home:
                            HomeView()
                        case .wishes:
                            WishesView()
                        case .categories:
                            CategoriesView()
                        case .cart:
                            CartView()
                        case .profile:
                            ProfileView()
                        }
                        
                        ZStack {
                            VStack(spacing: 0) {
                                CustomDivider()
                                
                                HStack(spacing: 4) {
                                    TabBarIcon(appState: appState, assignedPage: .home, width: geometry.size.width/6, height: geometry.size.height/30, iconName: "ic_home", tabName: LocalizedStringKey.home, isAddButton: false)
                                    
                                    Spacer()

                                    TabBarIcon(appState: appState, assignedPage: .wishes, width: geometry.size.width/6, height: geometry.size.height/30, iconName: "ic_wishes", tabName: LocalizedStringKey.wishes, isAddButton: false)

                                    Spacer()

                                    TabBarIcon(appState: appState, assignedPage: .categories, width: geometry.size.width/6, height: geometry.size.height/30, iconName: "ic_category", tabName: LocalizedStringKey.categories, isAddButton: false)

                                    Spacer()

                                    TabBarIcon(appState: appState, assignedPage: .cart, width: geometry.size.width/6, height: geometry.size.height/30, iconName: "ic_cart", tabName: LocalizedStringKey.cart, isAddButton: false)
                                    
                                    Spacer()

                                    TabBarIcon(appState: appState, assignedPage: .profile, width: geometry.size.width/6, height: geometry.size.height/30, iconName: "ic_profile", tabName: LocalizedStringKey.profile, isAddButton: false)
                                }
                                .padding(.horizontal)
                                .frame(width: geometry.size.width, height: geometry.size.height/10)
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }
                .background(Color.background())
                .edgesIgnoringSafeArea(.bottom)
            }
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(Color.background(),for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: AppRouter.Destination.self) { destination in
                switch destination {
                case .profile:
                    ProfileView()
                case .editProfile:
                    EditProfileView()
                case .changePassword:
                    EmptyView()
//                    ChangePasswordView()
                case .changePhoneNumber:
                    EmptyView()
//                    ChangePhoneNumberView()
                case .contactUs:
                    EmptyView()
//                    ContactUsView()
                case .rewards:
                    EmptyView()
//                    RewardsView()
                case .paymentSuccess:
                    SuccessView()
                case .constant(let item):
                    ConstantView(item: .constant(item))
                case .myOrders:
                    MyOrdersView()
                case .orderDetails:
                    OrderDetailsView()
                case .upcomingReminders:
                    UpcomingRemindersView()
                case .otherWishListView:
                    OtherWishListView()
                case .productDetails:
                    ProductDetailsView()
                case .selectedGiftView:
                    SelectedGiftView()
                case .friendWishes:
                    FriendWishesView()
                case .friendWishesListView:
                    FriendWishesListView()
                case .friendWishesDetailsView:
                    FriendWishesDetailsView()
                case .retailFriendWishesView:
                    RetailFriendWishesView()
                case .retailPaymentView:
                    RetailPaymentView()
                }
            }
            .popup(isPresented: Binding<Bool>(
                get: { appRouter.activePopup != nil },
                set: { _ in appRouter.togglePopup(nil) })
            ) {
               if let popup = appRouter.activePopup {
                   switch popup {
                   case .cancelOrder(let alertModel):
                       AlertView(alertModel: alertModel)
                   case .alert(let alertModel):
                       AlertView(alertModel: alertModel)
                   case .inputAlert(let alertModelWithInput):
                       InputAlertView(alertModel: alertModelWithInput)
                   }
               }
            } customize: {
                $0
                    .type(.toast)
                    .position(.bottom)
                    .animation(.spring())
                    .closeOnTapOutside(true)
                    .closeOnTap(false)
                    .backgroundColor(Color.black.opacity(0.80))
                    .isOpaque(true)
                    .useKeyboardSafeArea(true)
            }
            .popup(isPresented: Binding<Bool>(
                get: { appRouter.activePopupError != nil },
                set: { _ in appRouter.togglePopupError(nil) })
            ) {
               if let popup = appRouter.activePopupError {
                   switch popup {
                   case .alertError(let title, let message):
                       GeneralErrorToastView(title: title, message: message)
                   }
               }
            } customize: {
                $0
                    .type(.toast)
                    .position(.bottom)
                    .animation(.spring())
                    .closeOnTapOutside(true)
                    .closeOnTap(false)
                    .backgroundColor(Color.black.opacity(0.80))
                    .isOpaque(true)
                    .useKeyboardSafeArea(true)
            }
        }
        .accentColor(.black)
        .environmentObject(appRouter)
    }
}

#Preview {
    MainView()
        .environmentObject(UserSettings())
        .environmentObject(AppState())
}

