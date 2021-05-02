//
//  PreferenceManager.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation

struct UserPreferences {
    let searchType:SearchByType
    let selectedPincode:Int?
    let selectedDistrictID:Int?
    let selectedStateID:Int?
   // let selectedAge: Int?
}

struct PreferenceManager {
    
    let prefKeyPincode = "selected_pincode"
    let prefKeyState = "selected_state"
    let prefKeyDistrict = "selected_district"
    let prefKeySearchType = "selected_search_type"
    let prefKeySelectedAge = "selected_age"
    
    func registerDefaults() {
        let userdefaults = UserDefaults.standard
        userdefaults.register(defaults: [prefKeyPincode : ConfigConstants.defaultPincode,
                                         prefKeyDistrict : ConfigConstants.defaultDistictCode ,
                                         prefKeySearchType :ConfigConstants.defaultSearchType.rawValue ,
                                         prefKeyState : ConfigConstants.defaultStateCode
                                ])
        userdefaults.synchronize()
    }
    
    func getSavedPreferences() -> UserPreferences {
        let userdefaults = UserDefaults.standard
        let searchType = userdefaults.integer(forKey: prefKeySearchType)
        let pincode =  userdefaults.integer(forKey: prefKeyPincode)
        let district = userdefaults.integer(forKey: prefKeyDistrict)
        let stateID = userdefaults.integer(forKey: prefKeyState)
        let selectSearchType: SearchByType = SearchByType(rawValue: searchType) ?? .searchByPincode
       return UserPreferences(searchType: selectSearchType, selectedPincode: pincode, selectedDistrictID: district, selectedStateID: stateID)
    }
    
    func saveUserPreferences(_ preferences:UserPreferences) {
        let defaults  = UserDefaults.standard
        if let pincode = preferences.selectedPincode {
            defaults.setValue(pincode, forKey: prefKeyPincode)
        }
        
        if let district = preferences.selectedDistrictID {
            defaults.set(district, forKey: prefKeyDistrict)
        }
        let selectedSearchTypeValue = preferences.searchType.rawValue
        defaults.setValue(selectedSearchTypeValue, forKey: prefKeySearchType)
        
        defaults.synchronize()
    }
    
}

extension UserPreferences: CustomStringConvertible {
    var description: String {
        var searchTypeIdentifier = ""
        var searchTypeValues = ""
        switch searchType {
        case .searchByPincode:
            searchTypeIdentifier = "Pincode"
            searchTypeValues = " Pincode = \(selectedPincode?.string_rep ?? "")"
            
        case .searchByDistrict:
            searchTypeIdentifier = "District"
            searchTypeValues = "District = \(selectedDistrictID?.string_rep ?? ""))"
        }
        
        return "SearchType : \(searchTypeIdentifier), Selected \(searchTypeValues)"
    }
}
