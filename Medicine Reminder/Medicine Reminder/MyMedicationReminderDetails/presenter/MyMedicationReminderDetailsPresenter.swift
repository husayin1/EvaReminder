//
//  MyMedicationReminderDetailsPresenter.swift
//  Medicine Reminder
//
//  Created by husayn on 19/08/2024.
//

import Foundation

class MyMedicationReminderDetailsPresenter: MyMedicationsReminderDetailsPresenterProtocol {
    weak var view: MyMedicationsReminderDetailsViewProtocol?
    private let router: MyMedicationsReminderDetailsRouterProtocol
    private let interactor: MyMedicationsReminderDetailsInteractorInputProtocol
    var medicine: MedicationItem?
    
    init(view: MyMedicationsReminderDetailsViewProtocol,
         interactor: MyMedicationsReminderDetailsInteractorInputProtocol,
         router: MyMedicationsReminderDetailsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.showLoadingIndicator()
        guard let medicine = medicine else { return }
        Task{
            await interactor.getMedicationBy(id: medicine.medicationId)
        }
    }
    
    func didTapOnActiveButton(startDate: String, endDate: String, times: [String]) {
        let medicine = ReminderToActivate(medicationId: medicine?.medicationId ?? 0, status: NotificationStatus.active.rawValue, time: times, durationFrom: startDate, durationTo: endDate)
        Task{
            await interactor.activateNotificationFor(medicine: medicine)
        }
        print("medicine to post ",medicine)
        
    }
    
    func arrangePickers() {
        //if let times = medicine {
            for item in 1...2/*times.frequency*/ {
                view?.viewStack.addArrangedSubview((view?.createDosageTimePicker(labelText: "Dosage \(item) at:"))!)
            }
        //}
    }
    
}

extension MyMedicationReminderDetailsPresenter: MyMedicationsReminderDetailsInteractorOutputProtocol {
    func medicationFetchedByIdSuccessfully(medications: MedicationItem) {
        view?.hideLoadingIndicator()
        view?.setupDetailsView(medicine: medications)
        arrangePickers()
    }
    
    func medicationsFetchedByIdFailed(withError: Error) {
        view?.hideLoadingIndicator()
        view?.showToastWith(message: withError.localizedDescription)
    }
    
    func notificationActivatedSuccessfully() {
        view?.showToastWith(message: "You will be notified for this medicine")
    }
    
    func notificationActivationFailed(withError: Error) {
        view?.showToastWith(message: withError.localizedDescription)
    }
    
    
}
