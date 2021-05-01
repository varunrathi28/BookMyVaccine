//
//  AppointmentConfig.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation

public struct VaccineCrawlerConfig {
    
    static let crawlFreqency:TimeInterval = 10.0
    static let desiredDate = "02-05-2021"
    static let desiredPincode = "250004"
    static let minAge:Int = 45
    static let minCapacityThreshold: Int = 1
    
    static var body : [String:String] {
        return ["pincode":desiredPincode, "date":desiredDate]
    }
}
