//
//  APIClientTypeProtocol.swift
//  Medicine Reminder
//
//  Created by husayn on 26/08/2024.
//

import Foundation
import Combine

protocol APIClientTypeProtocol {
    func performRequest<T: Decodable>(route: MedicationReminderRoute)  async -> Result<T, NetworkError>
}
