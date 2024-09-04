//
//  MyMedicationsReminderDetailsEntity.swift
//  Medicine Reminder
//
//  Created by husayn on 26/08/2024.
//

import Foundation

//MARK: - Medication Details Response from API
struct MedicationDetailsResponse: Codable {
    let data: MedicationDetailsItem
    let message: String
    let errorList:[String]?
}

//MARK: - Medication Details Item for response
struct MedicationDetailsItem: Codable {
    let id: Int
    let doctorPrescribedMedicationId: Int
    let patientId: Int
    let startDate: String
    let endDate: String
    let status: Int
    let patient: String?
    let time: String?
    let doctorPrescribedMedication: String?
}

//MARK: - Activate ReminderFor Medication
struct ReminderToActivate: Codable {
    let medicationId: Int
    let status: String
    let time: [String]
    let durationFrom: String
    let durationTo: String
}

// MARK: - Reminder Activation API Response
struct ReminderActivationResponse: Codable {
    let data: ReminderActivation
    let message: String
    let errorList: [String]?
}

// MARK: - Data Structure
struct ReminderActivation: Codable {
    let id: Int
    let doctorPrescribedMedicationId: Int
    let patientId: Int
    let startDate: String
    let endDate: String
    let status: Int
    let patient: Patient?
    let time: [Time]
    let doctorPrescribedMedication: DoctorPrescribedMedication
}

// MARK: - Patient Structure
struct Patient: Codable {
    // Define properties here if needed, based on the actual data structure
}

// MARK: - Time Structure
struct Time: Codable {
    let id: Int
    let medicationReminderId: Int
    let time: String // Use String for time; consider using a DateFormatter if you need a Date object
    let medicationReminder: MedicationReminder? // Assuming medicationReminder is null, make it optional
}

// MARK: - DoctorPrescribedMedication Structure
struct DoctorPrescribedMedication: Codable {
    let id: Int
    let doctorPrescriptionId: Int
    let drugIndexId: Int
    let drugName: String
    let frequency: Int
    let frequencyDuration: String
    let period: Int
    let periodDuration: String
    let direction: String
    let isChronic: Bool
    let dosage: Int
    let doctorPrescription: DoctorPrescription? // Assuming doctorPrescription is null, make it optional
    let drugIndex: DrugIndex? // Assuming drugIndex is null, make it optional
    let medicationReminder: MedicationReminder? // Assuming medicationReminder is null, make it optional
    let titrations: [Titration]? // Assuming titrations is null, make it optional
}

// MARK: - Additional Structures (If Needed)
struct DoctorPrescription: Codable {
    // Define properties here if needed
}

struct DrugIndex: Codable {
    // Define properties here if needed
}

struct MedicationReminder: Codable {
    // Define properties here if needed
}

struct Titration: Codable {
    // Define properties here if needed
}


