//
//  MyMedicationReminderInteractor.swift
//  Medicine Reminder
//
//  Created by husayn on 19/08/2024.
//

import Foundation

class MyMedicationsReminderDetailsInteractor: MyMedicationsReminderDetailsInteractorInputProtocol {
    
    weak var presenter: MyMedicationsReminderDetailsInteractorOutputProtocol?
    
    var repository: MedicationsReminderDetailsRepositoryProtocol
    init(repo: MedicationsReminderDetailsRepositoryProtocol){
        self.repository = repo
    }
    
    func getMedicationBy(id: Int) async {
        let result = await repository.fetchMedicationReminderBy(id: id)
        switch result{
        case .success(let medicine):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.presenter?.medicationFetchedByIdSuccessfully(medications: medicine.data)
            }
        case .failure(let error):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.presenter?.medicationsFetchedByIdFailed(withError: error)
            }
        }
    }
    
    func activateNotificationFor(medicine: ReminderToActivate) async {
        let result = await repository.postMedicationReminder(for: medicine)
        switch result {
        case .success(let response):
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.presenter?.notificationActivatedSuccessfully()
                print("Activation Response -> ",response.message)
            }
        case .failure(let err):
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.presenter?.notificationActivationFailed(withError: err)
            }
        }
    }
}
