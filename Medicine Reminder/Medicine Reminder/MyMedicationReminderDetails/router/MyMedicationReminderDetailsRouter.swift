//
//  MyMedicationReminderDetailsRouter.swift
//  Medicine Reminder
//
//  Created by husayn on 19/08/2024.
//

import UIKit

class MyMedicationReminderDetailsRouter:  MyMedicationsReminderDetailsRouterProtocol{
    weak var viewController: UIViewController?
    
    static func createModule(medicineData: MedicationItem) -> UIViewController {
        let view = MedicationReminderDetailsViewController()
        let interactor: MyMedicationsReminderDetailsInteractorInputProtocol = MyMedicationsReminderDetailsInteractor(repo: MedicationsReminderRepository())
        
        let router = MyMedicationReminderDetailsRouter()
        //constructor bsaed depedency injection
        let presenter = MyMedicationReminderDetailsPresenter(view: view,interactor: interactor , router: router)
        
        //property based dependency injection
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.medicine = medicineData
        router.viewController = view
        return view
    }
}
