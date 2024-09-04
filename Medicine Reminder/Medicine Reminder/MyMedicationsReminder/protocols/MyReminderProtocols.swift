//
//  MyReminderProtocols.swift
//  Medicine Reminder
//
//  Created by husayn on 14/08/2024.
//

import Foundation
import UIKit


//MARK: - View -> Presenter
protocol MyMedicationsReminderViewProtocol: AnyObject {
    var presenter: MyMedicationsReminderPresenterProtocol? { get set}
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadData()
    func setupTableView()
    func showLongPressAlert(medicine: MedicationItem)
    func showToastWith(message: String)
}

//MARK: - Presenter -> View
protocol MyMedicationsReminderPresenterProtocol: AnyObject {
    var view: MyMedicationsReminderViewProtocol? {get set}
    var numberOfRows: Int { get }
    func viewDidLoad()
    func configure(cell: MedicationReminderCellConfiguration,indexPath: IndexPath)
    func didSelectMedicine(at index: Int)
    func medicineDidLongPressed(at index: Int)
    func snoozeNotification(for medicine: MedicationItem)
    func stopNotification(for medicine: MedicationItem)
}

//MARK: - Presenter -> Interactor
protocol MyMedicationsReminderInteractorInputProtocol: AnyObject {
    var presenter: MyMedicationsReminderInteractorOutputProtocol? { get set}
    func getMedications() async
    func updateStatus(to medicine: ReminderItemStatus) async
    func login(user: User) async 
}


//MARK: - Interactor -> Presenter
protocol MyMedicationsReminderInteractorOutputProtocol: AnyObject {
    func medicationsFetchedSuccessfully(medications: [MedicationItem])
    func medicationsFetchedFailed(withError: Error)
    func medicationStatusUpdatedSuccessfully(medication: MedicationDetailsResponse)
    func medicationStatusUpdateFailed(withError: Error)
}

//MARK: - Presenter -> Router
protocol MyMedicationsReminderRouterProtocol {
    static func createModule() -> UIViewController
    func navigateToMedicineDetails(medicineData: MedicationItem)
}

//MARK: - cell Configuration
protocol MedicationReminderCellConfiguration {
    func configureCell(medicationModel: MedicationItem)
}

