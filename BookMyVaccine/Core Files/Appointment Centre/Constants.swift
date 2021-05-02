//
//  Constants.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation

struct ConfigConstants{
    static let crawlFreqency:TimeInterval = 60.0
    static let minAge:Int = 18
    static let minCapacityThreshold: Int = 1
    static let defaultPincode = 250004
    static let defaultDistictCode = 676
    static let defaultStateCode = 34
    static let defaultSearchType:SearchByType = .searchByPincode
}
