//
//  AppRouter.swift
//  Wishy
//
//  Created by Karim Amsha on 27.04.2024.
//

import SwiftUI

final class AppRouter: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case profile
        case editProfile
        case changePassword
        case changePhoneNumber
        case contactUs
        case rewards
        case paymentSuccess
        case constant(ConstantItem)
        case myOrders
        case orderDetails
        case upcomingReminders
        case otherWishListView
        case productDetails
        case selectedGiftView
        case friendWishes
        case friendWishesListView
        case friendWishesDetailsView
        case retailFriendWishesView
        case retailPaymentView
    }
    
    public enum Popup: Hashable {
        case cancelOrder(AlertModel)
        case alert(AlertModel)
        case inputAlert(AlertModelWithInput)
    }

    public enum GeneralError: Hashable {
        case alertError(String, String)
    }

    @Published var navPath = NavigationPath()
    @Published var activePopup: Popup? = nil
    @Published var activePopupError: GeneralError? = nil

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        if !navPath.isEmpty {
            navPath.removeLast()
        }
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    func togglePopup(_ popup: Popup?) {
        activePopup = popup
    }
    
    func togglePopupError(_ popupError: GeneralError?) {
        activePopupError = popupError
    }
    
    func dismissPopup() {
        activePopup = nil
    }
    
    func dismissPopupError() {
        activePopupError = nil
    }
}

