//
//  Constants.swift
//  Medicine Reminder
//
//  Created by husayn on 15/08/2024.
//

import Foundation

enum Constants: String {
    case baseUrl = "http://ec2-54-171-240-65.eu-west-1.compute.amazonaws.com/"
    static var bearerToken: String {
        UserDefaultsManager.shared.bearerToken ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiI1IiwiVXNlclR5cGUiOiJQYXRpZW50IiwibmJmIjoxNzI0NjgwODE0LCJleHAiOjE3NTYyMTY4MTQsImlhdCI6MTcyNDY4MDgxNCwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NzA5OSIsImF1ZCI6Ik1lZGljaW5lUmVtaW5kZXJBUEkifQ.XDjBoxEJ8EIJgy6x76vSx-_74oo5xLQ1n9IdSbxcyz8"
    }
}


enum NotificationStatus: String{
    case active = "Active"
    case stop = "Inactive"
    case snoozed = "Snoozed"
}
