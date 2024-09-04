//
//  MedicationsReminderRepository.swift
//  Medicine Reminder
//
//  Created by husayn on 15/08/2024.
//

import Foundation

class MedicationsReminderRepository: MedicationsReminderRepositoryProtocol, MedicationsReminderDetailsRepositoryProtocol{
    
    // MARK: - Properties
    private let apiClient: MedicationReminderAPIClient
    
    // MARK: - Init
    init() {
        self.apiClient = MedicationReminderAPIClient()
    }
    
    // MARK: - Network Calls
    func fetchPatientMedicationsReminder() async -> Result<MedicationsResponse, NetworkError> {
        return await apiClient.fetchAllMedications()
    }
    
    func updateMedicationReminderStatus(medicine: ReminderItemStatus) async -> Result<MedicationDetailsResponse, NetworkError> {
        return await apiClient.updateMeicationStatus(medicine: medicine)
    }
    
    func fetchMedicationReminderBy(id: Int) async -> Result<ReminderResponse, NetworkError>{
        return await apiClient.fetchMedicationById(id: id)
    }
    
    func postMedicationReminder(for medicine: ReminderToActivate) async -> Result<ReminderActivationResponse, NetworkError> {
        return await apiClient.postMedicationReminder(notification: medicine)
    }
    
    func login(user: User) async -> Result<AuthResponse, NetworkError> {
        return await apiClient.login(user: user)
    }
    
    
}
