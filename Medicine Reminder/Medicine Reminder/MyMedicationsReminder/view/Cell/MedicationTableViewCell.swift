//
//  MedicationTableViewCell.swift
//  Medicine Reminder
//
//  Created by husayn on 17/08/2024.
//

import UIKit

class MedicationTableViewCell: UITableViewCell, MedicationReminderCellConfiguration {
    
    static let identifier = "MedicationTableViewCell"
    @IBOutlet weak private var medicationName: UILabel!
     
    func configureCell(medicationModel: MedicationItem) {
        self.medicationName.text = medicationModel.medicationName
    }
    
    
}
