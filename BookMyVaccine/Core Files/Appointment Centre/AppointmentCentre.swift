//
//  AppointmentCentre.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation

public class AppointmentCentre {
    
    let apiClient:AppointmentAPIClient
    let validator: AppointmentValidator
    let notfier:AppointmentNotifier
    
    init(_ apiClient: AppointmentAPIClient, _ validator:AppointmentValidator, _ notifier:AppointmentNotifier) {
        self.apiClient = apiClient
        self.notfier = notifier
        self.validator = validator
    }
    
   @objc func checkAppointments() {
    let selectedSearchType = PreferenceManager().getSavedPreferences().searchType
    self.apiClient.checkForAvailableSessions(searchBy: selectedSearchType)
        { [weak self] (data) in
            guard let self = self else { return }
               
            if let validResponse = data {
               let availableCentres = self.validator.validateApointments(validResponse) {
                $0.min_age_limit == ConfigConstants.minAge && $0.available_capacity > ConfigConstants.minCapacityThreshold
                }
                if !availableCentres.isEmpty {
                    self.notfier.notify(for: availableCentres)
                }
            }
        }
    
    }
}
