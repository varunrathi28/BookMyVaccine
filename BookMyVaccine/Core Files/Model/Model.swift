//
//  Model.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation

public struct AppointmentResponse : Codable {
   public let centers: [VaccineCentre]
}


public struct VaccineCentre :Codable{
    let block_name : String
    let center_id : Double
    let district_name:String
    let fee_type: String
    let from:String
    let lat :Int
    let long : Int
    let name : String
    let pincode:Int
    let state_name:String
    let sessions: [SessionInfo]

}

struct SessionInfo : Codable{
    let available_capacity:Int
    let date: String
    let min_age_limit:Int
    let session_id:String
    let vaccine:String
    let slots: [String]
}

