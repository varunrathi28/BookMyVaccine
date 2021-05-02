//
//  AppointmentConfig.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation

enum SearchByType : Int{
    case searchByPincode
    case searchByDistrict
}

struct URLConstants {
    
    static let baseURL = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/"
    static let pathPincode = "calendarByPin"
    static let pathDistrict = "calendarByDistrict"
    
}

public struct ParameterConfig {
    private let apiKey_pincode = "pincode"
    private let apiKey_districtid = "district_id"
    private let apiKey_date = "date"
    private var desiredPincode: String {
        if let pincode =  PreferenceManager().getSavedPreferences().selectedPincode {
            return pincode.string_rep
        }
        return ConfigConstants.defaultPincode.string_rep
    }
    private var desiredDistrict: String {
        if let district =  PreferenceManager().getSavedPreferences().selectedDistrictID {
            return district.string_rep
        }
        return ConfigConstants.defaultDistictCode.string_rep
    }
    
    
     let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter
    }()
    
     func getBody(for searchType:SearchByType = .searchByPincode)-> [String: String]{
        var body = [String:String]()
        let currentDate = self.dateFormatter.string(from: Date())
        body[apiKey_date] = currentDate
        
        switch searchType {
        case .searchByDistrict:
            body[apiKey_districtid] = desiredDistrict
            
        case .searchByPincode:
            body[apiKey_pincode] = desiredPincode
            
        }
        return body
    }
}
