//
//  MyMedicationsReminderRouter.swift
//  Medicine Reminder
//
//  Created by husayn on 14/08/2024.
//

import UIKit

class MyMedicationsReminderRouter: MyMedicationsReminderRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = MyMedicationReminderViewController()
        let interactor: MyMedicationsReminderInteractorInputProtocol = MyMedicationsReminderInteractor(repo: MedicationsReminderRepository())
        
        let router = MyMedicationsReminderRouter()
        //constructor bsaed depedency injection
        let presenter = MyMedicationsReminderPresenter(view: view, interactor: interactor, router: router)
        //property based dependency injection
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigateToMedicineDetails(medicineData: MedicationItem) {
        viewController?.navigationController?.pushViewController(MyMedicationReminderDetailsRouter.createModule(medicineData: medicineData), animated: false)
    }
}
