//
//  LoginView.swift
//  Wishy
//
//  Created by Karim Amsha on 27.04.2024.
//

import SwiftUI
import PopupView
import FirebaseMessaging
import MapKit
import Combine

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State var loginType: LoginType = .login
    @State var name: String = ""
    @State var email: String = ""
    @State var mobile: String = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State var isEditing: Bool = true
    @EnvironmentObject var settings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    @State var completePhoneNumber = ""
    @StateObject private var viewModel = AuthViewModel(errorHandling: ErrorHandling())
    @State private var userLocation: CLLocationCoordinate2D? = nil
    @State var countryCode : String = "+966"
    @State var countryFlag : String = "🇸🇦"
    @State var countryPattern : String = "## ### ####"
    @State var countryLimit : Int = 17
    let counrties: [CPData] = Bundle.main.decode("CountryNumbers.json")
    @State private var searchCountry: String = ""
    @Binding var loginStatus: LoginStatus
    @FocusState private var keyIsFocused: Bool
    @State var presentSheet = false
    @State private var privacyPolicyTapped = false
    @EnvironmentObject var appRouter: AppRouter

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    MobileView(mobile: $mobile, presentSheet: $presentSheet)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(LocalizedStringKey.password)
                            .customFont(weight: .regular, size: 12)
                            .foregroundColor(.black1F1F1F())
                        CustomSecureTextField(text: $password, placeholder: LocalizedStringKey.password, textColor: .black4E5556(), placeholderColor: .grayA4ACAD())
                            .disabled(viewModel.isLoading)
                            .roundedBackground(cornerRadius: 8, strokeColor: Color.primaryGreen(), lineWidth: 1)
                    }

                    Spacer()

                    // Show a loader while registering
                    if viewModel.isLoading {
                        LoadingView()
                    }

                    VStack(spacing: 16) {
                        Button {
                            Messaging.messaging().token { token, error in
                                if let error = error {
                                    appRouter.activePopupError = .alertError(LocalizedStringKey.error, error.localizedDescription)
                                } else if let token = token {
                                    register(fcmToken: token)
                                }
                            }
                        } label: {
                            Text(LocalizedStringKey.login)
                        }
                        .buttonStyle(GradientPrimaryButton(fontSize: 16, fontWeight: .bold, background: Color.primaryGradientColor(), foreground: .white, height: 48, radius: 12))
                        .disabled(viewModel.isLoading)
                        
                        Button {
                            viewModel.guest {
                                settings.loggedIn = true
                            }
                        } label: {
                            Text(LocalizedStringKey.guest)
                        }
                        .buttonStyle(PrimaryButton(fontSize: 16, fontWeight: .bold, background: .primaryLight(), foreground: .primaryDarker(), height: 48, radius: 8))
                        .disabled(viewModel.isLoading)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: geometry.size.height)
            }
        }
        .padding(24)
        .toolbarColorScheme(.light, for: .navigationBar)
        .toolbarBackground(Color.white,for: .navigationBar)
        .dismissKeyboardOnTap()
        .background(Color.white)
        .sheet(isPresented: $presentSheet) {
            NavigationStack {
                List(filteredResorts) { country in
                    
                    HStack {
                        Text(country.flag)
                        Text(country.name)
                            .font(.headline)
                        Spacer()
                        Text(country.dial_code)
                            .foregroundColor(.secondary)
                    }
                    .onTapGesture {
                        self.countryFlag = country.flag
                        self.countryCode = country.dial_code
                        self.countryPattern = country.pattern
                        self.countryLimit = country.limit
                        presentSheet = false
                        searchCountry = ""
                    }
                }
                .listStyle(.plain)
                .searchable(text: $searchCountry, prompt: LocalizedStringKey.yourCountry)
            }
            .environment(\.layoutDirection, .leftToRight)
        }
        .navigationBarBackButtonHidden()
        .background(Color.background())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image("ic_gift")

                    VStack(alignment: .leading, spacing: 2) {
                        Text(LocalizedStringKey.login)
                            .customFont(weight: .bold, size: 20)
                        
                        Text(LocalizedStringKey.loginHint)
                            .customFont(weight: .regular, size: 12)
                    }
                    .foregroundColor(Color.primaryBlack())
                }
            }
        }
        .onAppear {
            // Use the user's current location if available
            if let userLocation = LocationManager.shared.userLocation {
                self.userLocation = userLocation
            }
            
            #if DEBUG
            mobile = "535353533"
            password = "123123"
            #endif
        }
        .onChange(of: viewModel.errorMessage) { errorMessage in
            if let errorMessage = errorMessage {
                appRouter.togglePopupError(.alertError("", errorMessage))
            }
        }
    }
    
    private func getCompletePhoneNumber() -> String {
        completePhoneNumber = "\(countryCode)\(mobile)".replacingOccurrences(of: " ", with: "")
        
        // Remove "+" from countryCode
        if countryCode.hasPrefix("+") {
            completePhoneNumber = completePhoneNumber.replacingOccurrences(of: countryCode, with: String(countryCode.dropFirst()))
        }
        
        return completePhoneNumber
    }

    var filteredResorts: [CPData] {
        if searchCountry.isEmpty {
            return counrties
        } else {
            return counrties.filter { $0.name.contains(searchCountry) }
        }
    }
}

#Preview {
    LoginView(loginStatus: .constant(.login))
        .environmentObject(AppState())
        .environmentObject(UserSettings())
}

extension LoginView {
    func register(fcmToken: String) {
        appState.phoneNumber = getCompletePhoneNumber()
        
        var params: [String: Any] = [
            "phone_number": getCompletePhoneNumber(),
            "password": password,
            "os": "IOS",
            "fcmToken": fcmToken,
            "lat": userLocation?.latitude ?? 0.0,
            "lng": userLocation?.longitude ?? 0.0,
        ]

        // Check if user location is available
        if let userLocation = userLocation {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            
            Utilities.getAddress(for: userLocation) { address in
                params["address"] = address
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                self.continueRegistration(with: params)
            }
        } else {
            // No user location available, proceed with registration without address
            continueRegistration(with: params)
        }
    }

    private func continueRegistration(with params: [String: Any]) {
        viewModel.registerUser(params: params) { id, token in
            appState.userId = id
            loginStatus = .profile(token)
        }
    }
}

struct CustomSecureTextField: View {
    @Binding var text: String

    var placeholder: String
    var textColor: Color
    var placeholderColor: Color

    @State private var isSecure: Bool = true

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                )

            if text.isEmpty {
                Text(placeholder)
                    .customFont(weight: .regular, size: 14)
                    .foregroundColor(placeholderColor)
                    .padding(.horizontal, 8)
            }

            if isSecure {
                SecureField("", text: $text)
                    .customFont(weight: .regular, size: 14)
                    .foregroundColor(textColor)
                    .accentColor(Color.primary())
                    .padding(.horizontal, 8)
            } else {
                TextField("", text: $text)
                    .customFont(weight: .regular, size: 14)
                    .foregroundColor(textColor)
                    .accentColor(Color.primary())
                    .padding(.horizontal, 8)
            }
            HStack {
                Spacer()
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image("ic_eye")
                        .padding(.trailing, 16)
                        .foregroundColor(isSecure ? placeholderColor : textColor)
                }
            }
        }
    }
}
