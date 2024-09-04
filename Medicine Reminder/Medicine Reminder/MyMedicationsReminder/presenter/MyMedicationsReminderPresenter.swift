//
//  MyMedicationsReminderPresenter.swift
//  Medicine Reminder
//
//  Created by husayn on 14/08/2024.
//

import Foundation

class MyMedicationsReminderPresenter: MyMedicationsReminderPresenterProtocol {
    weak var view: MyMedicationsReminderViewProtocol?
    private let interactor: MyMedicationsReminderInteractorInputProtocol
    private let router: MyMedicationsReminderRouterProtocol
    
    private var medications = [MedicationItem]()
    
    var numberOfRows: Int {
        return medications.count
    }
    
    init(view: MyMedicationsReminderViewProtocol,
         interactor: MyMedicationsReminderInteractorInputProtocol,
         router: MyMedicationsReminderRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        view?.showLoadingIndicator()
        Task{
            await interactor.login(user: User(phoneNumber: "123", deviceToken: UserDefaultsManager.shared.deviceToken ?? "NotFound", os: "IOS"))
            await interactor.getMedications()
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.view?.reloadData()
            }
        }
        print("view did load should get data")
    }
    
    func configure(cell: MedicationReminderCellConfiguration, indexPath: IndexPath) {
        let medication = medications[indexPath.row]
        cell.configureCell(medicationModel: medication)
    }
    
    func didSelectMedicine(at index: Int) {
        router.navigateToMedicineDetails(medicineData: medications[index])
    }
    
    func medicineDidLongPressed(at index: Int) {
        view?.showLongPressAlert(medicine: medications[index])
    }
    
    func snoozeNotification(for medicine: MedicationItem) {
        let reminderStatus = ReminderItemStatus(doctorPrescribedMedicationId: medicine.medicationId, status: NotificationStatus.snoozed.rawValue)
        Task{
            await interactor.updateStatus(to: reminderStatus)
        }
    }
    
    func stopNotification(for medicine: MedicationItem) {
        let reminderStatus = ReminderItemStatus(doctorPrescribedMedicationId: medicine.medicationId, status: NotificationStatus.stop.rawValue)
        Task{
            await interactor.updateStatus(to: reminderStatus)
        }
        print("i should stop \(medicine.medicationName) ")
    }
    
}




extension MyMedicationsReminderPresenter: MyMedicationsReminderInteractorOutputProtocol{
    func medicationsFetchedSuccessfully(medications: [MedicationItem]) {
        view?.hideLoadingIndicator()
        self.medications.append(contentsOf: medications)
        print("success")
    }
    
    func medicationsFetchedFailed(withError: Error) {
        view?.hideLoadingIndicator()
        view?.showToastWith(message: withError.localizedDescription)
        print("failed and should show alert or sth")
    }
    
    func medicationStatusUpdatedSuccessfully(medication: MedicationDetailsResponse) {
        view?.showToastWith(message: medication.message)
        print("Medication Status changed for \(medication.data.id)")
    }
    
    func medicationStatusUpdateFailed(withError: Error) {
        view?.showToastWith(message: withError.localizedDescription)
        print("Medication Status failed to change with \(withError)")
    }
}

