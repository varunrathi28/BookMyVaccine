//
//  AppointmentCentre.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation

public class AppointmentCentre {
    
    let apiClient:APIClient
    let validator: AppointmentValidator
    let notfier:AppointmentNotifier
    
    init(_ apiClient: APIClient, _ validator:AppointmentValidator, _ notifier:AppointmentNotifier) {
        self.apiClient = apiClient
        self.notfier = notifier
        self.validator = validator
    }
    
   @objc func checkAppointments() {
    let body = VaccineCrawlerConfig.body
        self.apiClient.checkForAvailableSessions(body) { [weak self] (data) in
            guard let self = self else { return }
               
            if let validResponse = data {
               let availableCentres = self.validator.checkApointments(validResponse) {
                $0.min_age_limit == VaccineCrawlerConfig.minAge && $0.available_capacity > VaccineCrawlerConfig.minCapacityThreshold
                }
                if !availableCentres.isEmpty {
                    self.notfier.notify(for: availableCentres)
                }
            }
        }
    
    }
    
    
}
