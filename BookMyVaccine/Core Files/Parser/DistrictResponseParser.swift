//
//  DistrictResponseParser.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation

struct DistrictResponseParser {
    
    func parse(_ json:Data?) -> DistrictResponse?  {
        
        guard let data = json else { return nil}
        let jsonDecoder = JSONDecoder()
        do {
            let stateResponse = try jsonDecoder.decode(DistrictResponse.self, from: data)
            return stateResponse
        }catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
