//
//  MyMedicationReminderViewController.swift
//  Medicine Reminder
//
//  Created by husayn on 17/08/2024.
//

import UIKit
import Toast

class MyMedicationReminderViewController: UIViewController, MyMedicationsReminderViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    private var activityIndicator:UIActivityIndicatorView?
    var presenter: MyMedicationsReminderPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func setupTableView(){
        self.title = "Medications"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MedicationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MedicationTableViewCell.identifier)
    }
    
    func showLoadingIndicator() {
        print("show loading indicator")
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator?.center = (self.view?.center)!
        self.activityIndicator?.startAnimating()
        self.activityIndicator?.isHidden = false
        self.activityIndicator?.color = .blue
        self.view.addSubview(self.activityIndicator!)
    }
    
    func hideLoadingIndicator() {
        print("hide loading indicator")
        self.activityIndicator?.stopAnimating()
        self.activityIndicator?.isHidden = true
    }
    
    func reloadData() {
        tableView.reloadData()
        print("reloading data")
    }
    
    func showToastWith(message: String){
        self.view.makeToast(message)
    }
    
}

//MARK: - setup table view
extension MyMedicationReminderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MedicationTableViewCell.identifier) as! MedicationTableViewCell
        presenter?.configure(cell: cell, indexPath: indexPath)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        cell.addGestureRecognizer(longPressGesture)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectMedicine(at: indexPath.row)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            // Get the location of the long press
            let location = gestureRecognizer.location(in: tableView)
            
            // Get the indexPath of the cell where the long press occurred
            if let indexPath = tableView.indexPathForRow(at: location) {
                print("Long pressed on row: \(indexPath.row)")
                presenter?.medicineDidLongPressed(at: indexPath.row)
            }
        }
    }
    
    func showLongPressAlert(medicine: MedicationItem){
        let alert = UIAlertController(title: medicine.medicationName, message: "Do you want to stop notification for \(String(describing: medicine.medicationName)).", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Snooze for 1 week", style: .default, handler: {[weak self] _ in
            guard let self = self else { return }
            self.presenter?.snoozeNotification(for: medicine)
        }))
        alert.addAction(UIAlertAction(title: "Stop Notifications", style: .destructive, handler: {
            [weak self] _ in
            guard let self = self else { return }
            self.presenter?.stopNotification(for: medicine)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
