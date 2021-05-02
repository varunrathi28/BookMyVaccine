//
//  District.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation

struct DistrictResponse: Codable {
    let districts : [District]
    let ttl:Int
}
struct District :Codable, Hashable{
    let district_id: Int
    let district_name: String
}
