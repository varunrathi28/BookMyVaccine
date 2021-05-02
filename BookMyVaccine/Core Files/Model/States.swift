//
//  States.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation

struct StatesResponse: Codable{
    let states:[State]
    let ttl:Int
}

struct State: Codable, Hashable{
    let state_id: Int
    let state_name :String
}
