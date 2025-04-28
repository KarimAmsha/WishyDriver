import Foundation

// MARK: - Items
struct User: Codable, Hashable {
    let createAt: String?
    let isBlock: Bool?
    let rate: Double?
    let id: String?
    let image: String?
    let email: String?
    let phoneNumber: String?
    let password: String?
    let fullName: String?
    let supervisorID: String?
    let address: String?
    let supplierID: String?
    let os: String?
    let verifyCode: String?
    let token: String?
    let fcmToken: String?
    let isDeleted: Bool?
    let isVerify: Bool?
    let isAvailable: Bool?
    let completeOrder: Int?
    let activeOrder: Int?

    enum CodingKeys: String, CodingKey {
        case createAt
        case isBlock
        case rate
        case id = "_id"
        case image
        case email
        case phoneNumber = "phone_number"
        case password
        case fullName = "full_name"
        case supervisorID = "supervisor_id"
        case address
        case supplierID = "supplier_id"
        case os
        case verifyCode = "verify_code"
        case token
        case fcmToken
        case isDeleted
        case isVerify
        case isAvailable
        case completeOrder = "CompleteOrder"
        case activeOrder = "ActiveOrder"
    }
}
