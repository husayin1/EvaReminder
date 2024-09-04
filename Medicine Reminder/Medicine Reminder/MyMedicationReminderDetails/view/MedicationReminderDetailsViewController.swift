//
//  MedicationReminderDetailsViewController.swift
//  Medicine Reminder
//
//  Created by husayn on 19/08/2024.
//

import UIKit

class MedicationReminderDetailsViewController: UIViewController, MyMedicationsReminderDetailsViewProtocol {
    
    @IBOutlet weak var medicineName: UILabel!
    
    @IBOutlet weak var dosageLbl: UILabel!
    
    @IBOutlet weak var startDate: UIDatePicker!
    
    @IBOutlet weak var endDate: UIDatePicker!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var directionsLbl: UILabel!
    
    @IBOutlet weak var viewStack: UIStackView!
    
    private var activityIndicator:UIActivityIndicatorView?

    var timePickers: [UIDatePicker] = [] // Array to store references to UIDatePickers
    
    var presenter: MyMedicationsReminderDetailsPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
    }
    
    
    func setupDetailsView(medicine: MedicationItem){
        startDate.minimumDate = Date()
        endDate.minimumDate = Date()
        medicineName.text = medicine.medicationName
        dosageLbl.text = "\(medicine.dosage)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let beginDate = dateFormatter.date(from: medicine.durationFrom) {
            startDate.setDate(beginDate, animated: false)
        }
        if let finishDate = dateFormatter.date(from: medicine.durationTo) {
            endDate.setDate(finishDate, animated: false)
        }
        statusLbl.text = medicine.status
        directionsLbl.text = medicine.direction ?? "No Directions"
    }
    
    func createDosageTimePicker(labelText: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        
        let label = UILabel()
        label.text = labelText
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .inline // or .wheel ,.compact, .inline
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(timePicker)
        timePickers.append(timePicker)
        return stack
    }
    
    @IBAction func activateNotification(_ sender: Any) {
        let times = formatTime()
        let begin = formatDate().0
        let end = formatDate().1
        presenter?.didTapOnActiveButton(startDate: begin, endDate: end,times: times)
    }
    
    func formatDate() -> (String, String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let startDateString = dateFormatter.string(from: startDate.date)
        let endDateString = dateFormatter.string(from: endDate.date)
        
        return (startDateString, endDateString)
    }
    
    func formatTime() -> [String] {
        var data: [String] = []
        for timePicker in timePickers {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let timeString = formatter.string(from: timePicker.date)
            print("Selected time: \(timeString)")
            data.append(timeString)
        }
        return data
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
    func showToastWith(message: String){
        self.view.makeToast(message)
    }
}
