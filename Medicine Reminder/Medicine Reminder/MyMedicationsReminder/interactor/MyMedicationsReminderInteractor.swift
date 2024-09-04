//
//  MyMedicationsReminderInteractor.swift
//  Medicine Reminder
//
//  Created by husayn on 14/08/2024.
//

import Foundation

class MyMedicationsReminderInteractor: MyMedicationsReminderInteractorInputProtocol {
    
    weak var presenter: MyMedicationsReminderInteractorOutputProtocol?
    
    var repository: MedicationsReminderRepositoryProtocol
    init(repo: MedicationsReminderRepositoryProtocol){
        self.repository = repo
    }
    
    func getMedications() async {
        let result = await repository.fetchPatientMedicationsReminder()
        switch result {
        case .success(let medications):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.presenter?.medicationsFetchedSuccessfully(medications: medications.data)
            }
        case .failure(let error):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.presenter?.medicationsFetchedFailed(withError: error)
            }
        }
    }
    
    func updateStatus(to medicine: ReminderItemStatus) async {
        let result = await repository.updateMedicationReminderStatus(medicine: medicine)
        switch result {
        case .success(let medication):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.presenter?.medicationStatusUpdatedSuccessfully(medication: medication)
            }
        case .failure(let error):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.presenter?.medicationStatusUpdateFailed(withError: error)
            }
        }
    }
    
    func login(user: User) async {
        let result = await repository.login(user: user)
        switch result {
        case .success(let response):
            DispatchQueue.main.async {
                UserDefaultsManager.shared.bearerToken = response.data
            }
        case .failure(let err):
            print("error in auth \(err)")
        }
    }
}

