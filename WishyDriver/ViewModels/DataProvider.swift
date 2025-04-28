//
//  DataProvider.swift
//  Wishy
//
//  Created by Karim Amsha on 27.04.2024.
//

import Foundation
import Alamofire
import Combine

class DataProvider {
    static let shared = DataProvider()
    
    private let apiClient = APIClient.shared
    
    enum Endpoint {
        case getWelcome
        case getConstants
        case getConstantDetails(_id: String)
        case register(params: [String: Any])
        case verify(params: [String: Any])
        case resend(params: [String: Any])
        case updateUserDataWithImage(params: [String: Any], imageData: Data?, token: String)
//        case updateUserDataWithImage(params: [String: Any], imageFiles: [(Data, String)]?, token: String)
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
        case createReferal(token : String)
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
        case deleteAccount(id: String, token: String)
        case guest
        case getContact
        case tamaraCheckout(params: [String: Any], token: String)
        case checkPlace(params: [String: Any], token: String)
        case checkPoint(params: [String: Any], token: String)
        case rechangePoint(params: [String: Any], token: String)
        case confirmUpdateCode(id: String, params: [String: Any], token: String)
        case updateAvailability(params: [String: Any], token: String)
        case orderCount(token: String)
        case refreshFcmToken(params: [String: Any], token: String)

        // Map your custom Endpoint to APIEndpoint
        func toAPIEndpoint() -> APIEndpoint {
            switch self {
            case .getWelcome:
                return .getWelcome
            case .getConstants:
                return .getConstants
            case .getConstantDetails( let _id):
                return .getConstantDetails(_id: _id)
            case .register(let params):
                return .register(params: params)
            case .verify(let params):
                return .verify(params: params)
            case .resend(let params):
                return .resend(params: params)
            case .updateUserDataWithImage(let params, let imageData, let token):
                return .updateUserDataWithImage(params: params, imageData: imageData, token: token)
//            case .updateUserDataWithImage(let params, let imageFiles, let token):
//                return .updateUserDataWithImage(params: params, imageFiles: imageFiles, token: token)
            case .updateUserData(let params, let token):
                return .updateUserData(params: params, token: token)
            case .getUserProfile(let token):
                return .getUserProfile(token: token)
            case .logout(let userID):
                return .logout(userID: userID)
            case .addOrder(let params, let token):
                return .addOrder(params: params, token: token)
            case .map(let params, let token):
                return .map(params: params, token: token)
            case .addOfferToOrder(let orderId, let params, let token):
                return .addOfferToOrder(orderId: orderId, params: params, token: token)
            case .updateOfferStatus(let orderId, let params, let token):
                return .updateOfferStatus(orderId: orderId, params: params, token: token)
            case .updateOrderStatus(let orderId, let params, let token):
                return .updateOrderStatus(orderId: orderId, params: params, token: token)
            case .getOrders(let page, let limit, let params, let token):
                return .getOrders(page: page, limit: limit, params: params, token: token)
            case .getOrderDetails(let orderId, let token):
                return .getOrderDetails(orderId: orderId, token: token)
            case .addReview(let orderID, let params, let token):
                return .addReview(orderID: orderID, params: params, token: token)
            case .getNotifications(let page, let limit, let token):
                return .getNotifications(page: page, limit: limit, token: token)
            case .deleteNotification(let id, let token):
                return .deleteNotification(id: id, token: token)
            case .getWallet(let page, let limit, let token):
                return .getWallet(page: page, limit: limit, token: token)
            case .addBalanceToWallet(let params, let token):
                return .addBalanceToWallet(params: params, token: token)
            case .addComplain(let params, let token):
                return .addComplain(params: params, token: token)
            case .createReferal(let token):
                return .createReferal(token: token)
            case .checkCoupon(let params, let token):
                return .checkCoupon(params: params, token: token)
            case .getCategories(let q, let id):
                return .getCategories(q: q, id: id)
            case .getSubCategories(let q, let id):
                return .getSubCategories(q: q, id: id)
            case .addAddress(let params, let token):
                return .addAddress(params: params, token: token)
            case .updateAddress(let params, let token):
                return .updateAddress(params: params, token: token)
            case .deleteAddress(let id, let token):
                return .deleteAddress(id: id, token: token)
            case .getAddressByType(let type, let token):
                return .getAddressByType(type: type, token: token)
            case .getAddressList(let token):
                return .getAddressList(token: token)
            case .getTotalPrices(let params, let token):
                return .getTotalPrices(params: params, token: token)
            case .getRates(let page, let limit, let id, let token):
                return .getRates(page: page, limit: limit, id: id, token: token)
            case .getAppConstants:
                return .getAppConstants
            case .getHome:
                return .getHome
            case .deleteAccount(let id, let token):
                return .deleteAccount(id: id, token: token)
            case .guest:
                return .guest
            case .getContact:
                return .getContact
            case .tamaraCheckout(let params, let token):
                return .tamaraCheckout(params: params, token: token)
            case .checkPlace(let params, let token):
                return .checkPlace(params: params, token: token)
            case .checkPoint(let params, let token):
                return .checkPoint(params: params, token: token)
            case .rechangePoint(let params, let token):
                return .rechangePoint(params: params, token: token)
            case .confirmUpdateCode(let id, let params, let token):
                return .confirmUpdateCode(id: id, params: params, token: token)
            case .updateAvailability(let params, let token):
                return .updateAvailability(params: params, token: token)
            case .orderCount(let token):
                return .orderCount(token: token)
            case .refreshFcmToken(let params, let token):
                return .refreshFcmToken(params: params, token: token)
            }
        }
    }
    
    // Use a Combine Publisher for API calls
    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, APIClient.APIError> {
        let apiEndpoint = endpoint.toAPIEndpoint()
        return apiClient.requestPublisher(endpoint: apiEndpoint)
    }
    
    // Updated request function using completion handler
    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, APIClient.APIError>) -> Void) {
        let apiEndpoint = endpoint.toAPIEndpoint()
        apiClient.request(endpoint: apiEndpoint) { (result: Result<T, APIClient.APIError>) in
            switch result {
            case .success(let decodedObject):
                completion(.success(decodedObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendDataToAPI<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, APIClient.APIError>) -> Void
    ) {
        let apiEndpoint = endpoint.toAPIEndpoint()
        
        apiClient.sendData(endpoint: apiEndpoint) { (result: Result<Any, AFError>) in
            switch result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(decodedObject))
                } catch let decodingError as DecodingError {
                    let mappedError = self.apiClient.mapDecodingError(decodingError)
                    completion(.failure(mappedError))
                } catch {
                    completion(.failure(.unknownError))
                }
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }

//    func requestMultipart<T: Decodable>(endpoint: Endpoint, imageFiles: [(Data, String)]?, responseType: T.Type) -> AnyPublisher<T, APIClient.APIError> {
//        let apiEndpoint = endpoint.toAPIEndpoint()
//        return apiClient.requestMultipartPublisher(endpoint: apiEndpoint, imageFiles: imageFiles)
//    }
    
    func requestMultipart<T: Decodable>(endpoint: Endpoint, imageFiles: [(Data, String)]?, responseType: T.Type) -> AnyPublisher<(T, Double), APIClient.APIError> {
        let apiEndpoint = endpoint.toAPIEndpoint()
        return apiClient.requestMultipartPublisherWithProgress(endpoint: apiEndpoint, imageFiles: imageFiles)
    }
}
