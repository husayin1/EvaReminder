//
//  MyReminderDetailsProtocols.swift
//  Medicine Reminder
//
//  Created by husayn on 19/08/2024.
//

import UIKit
//MARK: - View -> Presenter
protocol MyMedicationsReminderDetailsViewProtocol: AnyObject {
    var presenter: MyMedicationsReminderDetailsPresenterProtocol? { get set}
    var viewStack: UIStackView! { get }
    func setupDetailsView(medicine: MedicationItem)
    func createDosageTimePicker(labelText: String) -> UIStackView
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showToastWith(message: String)
}

//MARK: - Presenter -> View
protocol MyMedicationsReminderDetailsPresenterProtocol: AnyObject {
    var view: MyMedicationsReminderDetailsViewProtocol? {get set}
    func viewDidLoad()
    func didTapOnActiveButton(startDate: String, endDate: String, times: [String])
}

//MARK: - Presenter -> Router
protocol MyMedicationsReminderDetailsRouterProtocol {
    static func createModule(medicineData: MedicationItem) -> UIViewController
}


//MARK: - Presenter -> Interactor
protocol MyMedicationsReminderDetailsInteractorInputProtocol: AnyObject {
    var presenter: MyMedicationsReminderDetailsInteractorOutputProtocol? { get set}
    func getMedicationBy(id: Int) async
    func activateNotificationFor(medicine: ReminderToActivate) async
}


//MARK: - Interactor -> Presenter
protocol MyMedicationsReminderDetailsInteractorOutputProtocol: AnyObject {
    func medicationFetchedByIdSuccessfully(medications: MedicationItem)
    func medicationsFetchedByIdFailed(withError: Error)
    func notificationActivatedSuccessfully()
    func notificationActivationFailed(withError: Error)
}


