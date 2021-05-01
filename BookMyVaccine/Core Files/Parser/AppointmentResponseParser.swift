//
//  AppointmentResponseParser.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation

public struct AppointmentResponseParser {
    func parse(_ json:Data?) -> AppointmentResponse? {
        
        guard let json = json else { return nil }
        let decoder = JSONDecoder()
        
        do {
            let appointmentResponse = try decoder.decode(AppointmentResponse.self, from: json)
            return appointmentResponse
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

