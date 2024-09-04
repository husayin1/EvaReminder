//
//  MedicationReminderAPIProtocol.swift
//  Medicine Reminder
//
//  Created by husayn on 26/08/2024.
//

import Foundation
protocol MedicationReminderAPIProtocol: APIClientTypeProtocol {
    func fetchAllMedications() async -> Result<MedicationsResponse, NetworkError>
    func fetchMedicationById(id: Int) async -> Result<ReminderResponse, NetworkError>
    func updateMeicationStatus(medicine: ReminderItemStatus) async -> Result<MedicationDetailsResponse, NetworkError>
    func postMedicationReminder(notification: ReminderToActivate) async -> Result<ReminderActivationResponse, NetworkError>
    func login(user: User) async -> Result <AuthResponse, NetworkError>
}
