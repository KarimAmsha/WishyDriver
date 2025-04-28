import Foundation
import Alamofire

// Function to get the user's preferred language code
func getUserPreferredLanguageCode() -> String? {
    return Locale.preferredLanguages.first?.components(separatedBy: "-").first
}

enum APIEndpoint {
    case getWelcome
    case getConstants
    case getConstantDetails(_id: String)
    case register(params: [String: Any])
    case verify(params: [String: Any])
    case resend(params: [String: Any])
//    case updateUserDataWithImage(params: [String: Any], imageFiles: [(Data, String)]?, token: String)
    case updateUserDataWithImage(params: [String: Any], imageData: Data?, token: String)
    case updateUserData(params: [String: Any], token: String)
    case getUserProfile(token: String)
    case logout(userID: String)
    case addOrder(params: [String: Any], token: String)
    case addOfferToOrder(orderId: String, params: [String: Any], token: String)
    case updateOfferStatus(orderId: String, params: [String: Any], token: String)
    case updateOrderStatus(orderId: String, params: [String: Any], token: String)
    case map(params: [String: Any], token: String)
    case getOrders(page: Int?, limit: Int?, params: [String: Any], token: String)
    case getOrderDetails(orderId: String, token: String)
    case addReview(orderID: String, params: [String: Any], token: String)
    case getNotifications(page: Int?, limit: Int?, token: String)
    case deleteNotification(id: String, token: String)
    case getWallet(page: Int?, limit: Int?, token: String)
    case addBalanceToWallet(params: [String: Any], token: String)
    case addComplain(params: [String: Any], token: String)
    case createReferal(token: String)
    case checkCoupon(params: [String: Any], token: String)
    case getCategories(q: String?, id: String?)
    case getSubCategories(q: String?, id: String?)
    case addAddress(params: [String: Any], token: String)
    case updateAddress(params: [String: Any], token: String)
    case deleteAddress(id: String, token: String)
    case getAddressByType(type: String, token: String)
    case getAddressList(token: String)
    case getTotalPrices(params: [String: Any], token: String)
    case getRates(page: Int?, limit: Int?, id: String, token: String)
    case getAppConstants
    case getHome
    case guest
    case deleteAccount(id: String, token: String)
    case getContact
    case tamaraCheckout(params: [String: Any], token: String)
    case checkPlace(params: [String: Any], token: String)
    case checkPoint(params: [String: Any], token: String)
    case rechangePoint(params: [String: Any], token: String)
    case confirmUpdateCode(id: String, params: [String: Any], token: String)
    case updateAvailability(params: [String: Any], token: String)
    case orderCount(token: String)
    case refreshFcmToken(params: [String: Any], token: String)

    // Define the base API URL
    private static let baseURL = Constants.baseURL
    
    // Computed property to get the full URL for each endpoint
    var fullURL: String {
        return APIEndpoint.baseURL + path
    }

    var path: String {
        switch self {
        case .getWelcome:
            return "/mobile/constant/welcome"
        case .getConstants:
            return "/mobile/constant/static"
        case .getConstantDetails(let _id):
            return "/mobile/constant/static/\(_id)"
        case .register:
            return "/driver/login"
        case .verify:
            return "/mobile/user/verify"
        case .resend:
            return "/mobile/user/resend"
        case .updateUserDataWithImage:
            return "/mobile/user/update-profile"
        case .updateUserData:
            return "/mobile/user/update-profile"
        case .getUserProfile:
            return "/driver/profile"
        case .logout(let userID):
            return "/mobile/employee/logout/\(userID)"
        case .addOrder:
            return "/mobile/order/add"
        case .addOfferToOrder(orderId: let orderId, _ , _):
            return "/mobile/order/offer/\(orderId)"
        case .updateOfferStatus(orderId: let orderId, _, _):
            return "/mobile/order/offer/update/\(orderId)"
        case .updateOrderStatus(orderId: let orderId, _, _):
            return "/mobile/order/update/\(orderId)"
        case .map(let params, _):
            if !params.isEmpty {
                var url = "/mobile/order/map?"
                url += params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                return url
            } else {
                return "/mobile/order/map"
            }
        case .getOrders(page: let page, limit: let limit, _, _):
            var params: [String: Any] = [:]

            if let page = page {
                params["page"] = page

            }
            if let limit = limit {
                params["limit"] = limit
            }

            if !params.isEmpty {
                var url = "/driver/order?"
                url += params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                return url
            } else {
                return "/driver/order"
            }
        case .getOrderDetails(orderId: let orderId, _):
            return "/mobile/order/single/\(orderId)"
        case .addReview(orderID: let orderID, _, _):
            return "/mobile/order/rate/\(orderID)"
        case .getNotifications(page: let page, limit: let limit, _):
            var params: [String: Any] = [:]

            if let page = page {
                params["page"] = page

            }
            if let limit = limit {
                params["limit"] = limit
            }

            if !params.isEmpty {
                var url = "/mobile/notification/get?"
                url += params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                return url
            } else {
                return "/mobile/notification/get"
            }
        case .deleteNotification(id: let id, _):
            return "/mobile/notification/delete/\(id)"
        case .getWallet(page: let page, limit: let limit, _):
            var params: [String: Any] = [:]

            if let page = page {
                params["page"] = page
            }
            if let limit = limit {
                params["limit"] = limit
            }

            if !params.isEmpty {
                var url = "/mobile/transaction/list?"
                url += params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                return url
            } else {
                return "/mobile/transaction/list"
            }
        case .addBalanceToWallet:
            return "/mobile/user/wallet"
        case .addComplain:
            return "/mobile/constant/add-complain"
        case .createReferal:
            return "/mobile/user/referal"
        case .checkCoupon:
            return "/mobile/check/coupon"
        case .getCategories( let q, let id):
            var params: [String: Any] = [:]

            if let q = q {
                params["q"] = q
            }
            if let id = id {
                params["id"] = id
            }
            if !params.isEmpty {
                var url = "/mobile/constant/main?"
                url += params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                return url
            } else {
                return "/mobile/constant/main"
            }
        case .getSubCategories( let q, let id):
            var params: [String: Any] = [:]

            if let q = q {
                params["q"] = q
            }
            if let id = id {
                params["id"] = id
            }
            if !params.isEmpty {
                var url = "/mobile/constant/category?"
                url += params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                return url
            } else {
                return "/mobile/constant/category"
            }
        case .addAddress:
            return "/mobile/user/add_address"
        case .updateAddress:
            return "/mobile/user/update_address"
        case .deleteAddress:
            return "/mobile/user/delete_address"
        case .getAddressByType(let type, _):
            return "/mobile/user/get_address/\(type)"
        case .getAddressList:
            return "/mobile/user/get_address"
        case .getTotalPrices:
            return "/mobile/order/totals"
        case .getRates(_, _, let id, _):
            return "/mobile/rates/\(id)"
        case .getAppConstants:
            return "/mobile/constant/get"
        case .getHome:
            return "/mobile/home/get"
        case .guest:
            return "/mobile/guest/token"
        case .deleteAccount(let id, _):
            return "/driver/delete/\(id)"
        case .getContact:
            return "/mobile/constant/contact_options"
        case .tamaraCheckout:
            return "/mobile/checkout"
        case .checkPlace:
            return "/mobile/check/place"
        case .checkPoint:
            return "/mobile/point/check"
        case .rechangePoint:
            return "/mobile/user/rechange"
        case .confirmUpdateCode( let id, _, _):
            return "/mobile/order/update/confirm/\(id)"
        case .updateAvailability:
            return "/driver/employee/available"
        case .orderCount:
            return "/driver/order-count"
        case .refreshFcmToken:
            return "/mobile/driver/refresh-fcm-token"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWelcome, .getConstants, .getUserProfile, .getConstantDetails, .map, .getOrderDetails, .getNotifications, .getWallet, .getCategories, .getSubCategories, .getAddressByType, .getAddressList, .getRates, .getAppConstants, .getHome, .guest, .getContact, .orderCount:
            return .get
        case .register, .verify, .resend, .updateUserDataWithImage, .updateUserData, .logout, .addOrder, .addOfferToOrder, .updateOfferStatus, .updateOrderStatus, .addReview, .deleteNotification, .addBalanceToWallet, .addComplain, .createReferal, .checkCoupon, .addAddress, .updateAddress, .deleteAddress, .getTotalPrices, .deleteAccount, .tamaraCheckout, .checkPlace, .checkPoint, .rechangePoint, .confirmUpdateCode, .updateAvailability, .getOrders, .refreshFcmToken:
            return .post
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getWelcome, .getConstants, .getConstantDetails, .register, .verify, .resend, .getCategories, .getSubCategories, .getAppConstants, .getHome, .guest, .getContact, .logout:
            var headers = HTTPHeaders()
            headers.add(name: "Accept-Language", value: getUserPreferredLanguageCode() ?? "ar")
            return headers
        case .getUserProfile(let token), .updateUserDataWithImage(_, _, let token), .updateUserData(_, let token), .addOrder(_, let token), .map(_, let token), .addOfferToOrder(_, _, let token), .updateOfferStatus(_, _, let token), .updateOrderStatus(_, _, let token), .getOrders(_, _, _, token: let token), .getOrderDetails(_, let token), .addReview(_, _, let token), .getNotifications(_, _, let token), .deleteNotification(_, let token), .getWallet(_, _, let token), .addBalanceToWallet(_, let token), .addComplain(_ , let token), .createReferal(let token), .checkCoupon(_, let token), .addAddress(_, let token), .updateAddress(_, let token), .deleteAddress(_, let token), .getAddressByType(_, let token), .getAddressList(let token), .getTotalPrices(_, let token), .getRates(_, _, _, let token), .deleteAccount(_, let token), .tamaraCheckout(_, let token), .checkPlace(_, let token), .checkPoint(_, let token), .rechangePoint(_, let token), .confirmUpdateCode(_, _, let token), .updateAvailability(_, let token), .orderCount(let token), .refreshFcmToken(_, let token):
            var headers = HTTPHeaders()
            headers.add(name: "Accept-Language", value: getUserPreferredLanguageCode() ?? "ar")
            headers.add(name: "token", value: token)
            return headers
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getWelcome, .getConstants, .getConstantDetails, .getUserProfile, .logout, .map, .getOrderDetails, .getNotifications, .deleteNotification, .getWallet, .createReferal, .getCategories, .getSubCategories, .getAddressByType, .getAddressList, .getRates, .getAppConstants, .getHome, .guest, .deleteAccount, .getContact, .orderCount:
            return nil
        case .register(let params), .verify(let params), .resend(let params), .updateUserDataWithImage(let params, _, _), .updateUserData(let params, _), .addOrder(let params, _), .addOfferToOrder(_, let params, _), .updateOfferStatus(_, let params, _), .updateOrderStatus(_, let params, _), .addReview(_, let params, _), .addBalanceToWallet(let params, _), .addComplain(let params, _), .checkCoupon(let params, _), .addAddress(let params, _), .updateAddress(let params, _), .getTotalPrices(let params, _), .tamaraCheckout(let params, _), .checkPlace(let params, _), .checkPoint(let params, _), .rechangePoint(let params, _), .confirmUpdateCode(_, let params, _), .updateAvailability(let params, _), .getOrders(_, _, let params, _), .refreshFcmToken(let params, _):
            return params
        case .deleteAddress(let id, _):
            let params: [String: Any] = ["id": id]
            return params
        }
    }
}

