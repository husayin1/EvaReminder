//
//  MedicationsReminderRepositoryProtocol.swift
//  Medicine Reminder
//
//  Created by husayn on 15/08/2024.
//

import Foundation

protocol MedicationsReminderRepositoryProtocol {
    func fetchPatientMedicationsReminder() async -> Result<MedicationsResponse, NetworkError>
    func updateMedicationReminderStatus(medicine: ReminderItemStatus) async -> Result<MedicationDetailsResponse, NetworkError>
    func login(user: User) async -> Result<AuthResponse, NetworkError>
}

protocol MedicationsReminderDetailsRepositoryProtocol {
    func fetchMedicationReminderBy(id: Int) async -> Result<ReminderResponse, NetworkError>
    func postMedicationReminder(for medicine:ReminderToActivate) async -> Result<ReminderActivationResponse, NetworkError>
}
