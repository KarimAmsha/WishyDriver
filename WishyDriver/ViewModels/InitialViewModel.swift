//
//  InitialViewModel.swift
//  Wishy
//
//  Created by Karim Amsha on 27.04.2024.
//

import SwiftUI
import Combine
import Alamofire

class InitialViewModel: ObservableObject {
    @Published var welcomeItems: [WelcomeItem]?
    @Published var constantsItems: [ConstantItem]?
//    @Published var whatsAppContactItem: Contact?
    @Published var constantItem: ConstantItem?
//    @Published var appconstantsItems: AppConstants?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    private let errorHandling: ErrorHandling
//    @Published var homeItems: [HomeItems]?

    init(errorHandling: ErrorHandling) {
        self.errorHandling = errorHandling
    }
    
    func fetchWelcomeItems() {
        isLoading = true
        errorMessage = nil
        let endpoint = DataProvider.Endpoint.getWelcome
        
        DataProvider.shared.request(endpoint: endpoint, responseType: ArrayAPIResponse<WelcomeItem>.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Use the centralized error handling component
                    self.handleAPIError(error)
                }
            }, receiveValue: { [weak self] (response: ArrayAPIResponse<WelcomeItem>) in
                if response.status {
                    self?.welcomeItems = response.items
                    self?.errorMessage = nil
                } else {
                    // Use the centralized error handling component
                    self?.handleAPIError(.customError(message: response.message))
                }
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func fetchConstantsItems() {
        isLoading = true
        errorMessage = nil
        let endpoint = DataProvider.Endpoint.getConstants
        
        DataProvider.shared.request(endpoint: endpoint, responseType: ArrayAPIResponse<ConstantItem>.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Use the centralized error handling component
                    self.handleAPIError(error)
                }
            }, receiveValue: { [weak self] (response: ArrayAPIResponse<ConstantItem>) in
                if response.status {
                    self?.constantsItems = response.items
                    self?.errorMessage = nil
                } else {
                    // Use the centralized error handling component
                    self?.handleAPIError(.customError(message: response.message))
                }
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func fetchConstantItemDetails(_id: String) {
        isLoading = true
        errorMessage = nil
        let endpoint = DataProvider.Endpoint.getConstantDetails(_id: _id)
        
        DataProvider.shared.request(endpoint: endpoint, responseType: SingleAPIResponse<ConstantItem>.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Use the centralized error handling component
                    self.handleAPIError(error)
                }
            }, receiveValue: { [weak self] (response: SingleAPIResponse<ConstantItem>) in
                if response.status {
                    self?.constantItem = response.items
                    self?.errorMessage = nil
                } else {
                    // Use the centralized error handling component
                    self?.handleAPIError(.customError(message: response.message))
                }
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
//    func fetchAppConstantsItems() {
//        isLoading = true
//        errorMessage = nil
//        let endpoint = DataProvider.Endpoint.getAppConstants
//        
//        DataProvider.shared.request(endpoint: endpoint, responseType: AppConstantsApiResponse.self)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    // Use the centralized error handling component
//                    self.handleAPIError(error)
//                }
//            }, receiveValue: { [weak self] (response: AppConstantsApiResponse) in
//                if response.status ?? false {
//                    self?.appconstantsItems = response.items
//                    self?.errorMessage = nil
//                } else {
//                    // Use the centralized error handling component
//                    self?.handleAPIError(.customError(message: response.message ?? ""))
//                }
//                self?.isLoading = false
//            })
//            .store(in: &cancellables)
//    }
    
//    func fetchHomeItems() {
//        isLoading = true
//        errorMessage = nil
//        let endpoint = DataProvider.Endpoint.getHome
//        
//        DataProvider.shared.request(endpoint: endpoint, responseType: ArrayAPIResponse<HomeItems>.self)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    // Use the centralized error handling component
//                    self.handleAPIError(error)
//                }
//            }, receiveValue: { [weak self] (response: ArrayAPIResponse<HomeItems>) in
//                if response.status {
//                    self?.homeItems = response.items
//                    self?.errorMessage = nil
//                } else {
//                    // Use the centralized error handling component
//                    self?.handleAPIError(.customError(message: response.message))
//                }
//                self?.isLoading = false
//            })
//            .store(in: &cancellables)
//    }
    
//    func fetchContactItems() {
//        isLoading = true
//        errorMessage = nil
//        let endpoint = DataProvider.Endpoint.getContact
//        
//        DataProvider.shared.request(endpoint: endpoint, responseType: ArrayAPIResponse<Contact>.self)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    // Use the centralized error handling component
//                    self.handleAPIError(error)
//                }
//            }, receiveValue: { [weak self] (response: ArrayAPIResponse<Contact>) in
//                if response.status {
//                    self?.whatsAppContactItem = response.items?.filter({$0.Name == "واتساب"}).first
//                    self?.errorMessage = nil
//                } else {
//                    // Use the centralized error handling component
//                    self?.handleAPIError(.customError(message: response.message))
//                }
//                self?.isLoading = false
//            })
//            .store(in: &cancellables)
//    }
}

extension InitialViewModel {
    private func handleAPIError(_ error: APIClient.APIError) {
        let errorDescription = errorHandling.handleAPIError(error)
        errorMessage = errorDescription
    }
}
