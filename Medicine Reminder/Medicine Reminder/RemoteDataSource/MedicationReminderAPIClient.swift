//
//  MedicationReminderAPIClient.swift
//  Medicine Reminder
//
//  Created by husayn on 26/08/2024.
//

import Foundation
class MedicationReminderAPIClient: APIClient,MedicationReminderAPIProtocol{
   
    func fetchAllMedications() async -> Result<MedicationsResponse, NetworkError> {
        return await performRequest(route: MedicationReminderRoute.getMedications)
    }
    
    func fetchMedicationById(id: Int) async -> Result<ReminderResponse, NetworkError> {
        return await performRequest(route: MedicationReminderRoute.getMedicationById(id: id))
    }
    func updateMeicationStatus(medicine: ReminderItemStatus) async -> Result<MedicationDetailsResponse, NetworkError>{
        return await performRequest(route: MedicationReminderRoute.updateMedicationStatus(status: medicine))
    }
    
    func postMedicationReminder(notification: ReminderToActivate) async -> Result<ReminderActivationResponse, NetworkError> {
        return await performRequest(route: MedicationReminderRoute.putMedicationReminder(reminder: notification))
    }
    
    func login(user: User) async -> Result<AuthResponse, NetworkError> {
        return await performRequest(route: MedicationReminderRoute.authentication(user: user))
    }
    
   
}
