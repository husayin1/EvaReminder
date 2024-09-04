//
//  MyMedicationsReminderEntity.swift
//  Medicine Reminder
//
//  Created by husayn on 15/08/2024.
//

import Foundation

//MARK: - to Get Medication List
//MARK: - Medication API Response For MyMedications View
struct MedicationsResponse: Codable {
    let data: [MedicationItem]
    let message: String
    let errorList: [String]?
}

//MARK: - Medication Item for List Of Meidications
struct MedicationItem: Codable {
    let medicationName: String
    let dosage: Int
    let direction: String?
    let status: String
    let durationFrom: String
    let durationTo: String
    let time: [String]?
    let medicationId: Int
    let frequency: Int
    let frequencyType: String
    let isChronic: Bool
    let period: Int
    let periodType: String
}

//MARK: - To UpdateReminder Status
//MARK: - Reminder API Response
struct ReminderResponse: Codable{
    let data: MedicationItem
    let message: String
    let errorList: [String]?
}

//MARK: - Reminder API Body
struct ReminderItemStatus: Codable{
    let doctorPrescribedMedicationId: Int
    let status: String
}



struct User: Codable {
    let phoneNumber: String
    let deviceToken: String
    let os: String
}

struct AuthResponse: Codable {
    let data: String
    let message: String
    let errorList:[String]?
}
