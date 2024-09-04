//
//  MedicationResources.swift
//  Medicine Reminder
//
//  Created by husayn on 26/08/2024.
//

import Foundation

enum MedicationReminderResources {
    case getMedications
    case getMedicationById
    case updateMedicationStatus
    case putMedicationReminder
    case authentication
    
    var endpoint: String {
        switch self {
        case .getMedications, .getMedicationById:
            return "api/medications"
        case .updateMedicationStatus:
            return "api/medications/UpdateStatus"
        case .putMedicationReminder:
            return "api/medications/SetReminder"
        case .authentication:
            return "api/Auth/Login"
        }
    }
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case accept = "Accept"
}

extension HTTPHeaderField {
    var token: String {
        switch self {
        case .authorization:
            return "Bearer \(Constants.bearerToken)"
        default:
            return self.rawValue
        }
    }
}

enum ContentType: String {
    case json = "application/json"
    case any = "*/*"
}
