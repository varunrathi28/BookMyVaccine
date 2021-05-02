//
//  AppointmentChecker.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation

public struct  AppointmentValidator {
    
    func validateApointments(_ response:AppointmentResponse, satisfying sessionFilterBlock : ((SessionInfo) -> Bool)) -> [VaccineCentre]{
        
        var eligibleCentres = [VaccineCentre]()
        for centre in response.centers {
            if  !centre.sessions.filter(sessionFilterBlock).isEmpty {
                eligibleCentres.append(centre)
            }
        }
        return eligibleCentres
    }
}
