//
//  MedicationReminderRoute.swift
//  Medicine Reminder
//
//  Created by husayn on 26/08/2024.
//

import Foundation
import Alamofire

enum MedicationReminderRoute: URLRequestConvertible {
    
    case getMedications
    case getMedicationById(id: Int)
    case updateMedicationStatus(status: ReminderItemStatus)
    case putMedicationReminder(reminder: ReminderToActivate)
    case authentication(user: User)

    var method: HTTPMethod {
        switch self {
        case .getMedications, .getMedicationById:
            return .get
        case .updateMedicationStatus:
            return .put
        case .putMedicationReminder, .authentication:
            return .post
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getMedications, .getMedicationById:
            return URLEncoding.default
        case .updateMedicationStatus, .putMedicationReminder, .authentication:
            return JSONEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getMedications, .getMedicationById:
            return nil
        case .updateMedicationStatus(let status):
            return try? status.asDictionary()
        case .putMedicationReminder(let reminder):
            return try? reminder.asDictionary()
        case .authentication(let user):
            return try? user.asDictionary()
        }
    }
    
    var path: String {
        switch self {
        case .getMedications:
            return MedicationReminderResources.getMedications.endpoint
        case .getMedicationById(let id):
            return "\(MedicationReminderResources.getMedicationById.endpoint)/\(id)"
        case .updateMedicationStatus:
            return MedicationReminderResources.updateMedicationStatus.endpoint
        case .putMedicationReminder:
            return MedicationReminderResources.putMedicationReminder.endpoint
        case .authentication:
            return MedicationReminderResources.authentication.endpoint
        }
    }
    
    var authorizationHeader: HTTPHeaderField? {
        return .authorization
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.rawValue.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        // Set the correct Content-Type header for JSON requests
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.any.rawValue, forHTTPHeaderField: HTTPHeaderField.accept.rawValue)
        
        if let headerField = authorizationHeader {
            urlRequest.setValue(headerField.token, forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}

// Helper extension to convert Encodable to Dictionary
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
    }
}
