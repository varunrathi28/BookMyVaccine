//
//  StateResponseParser.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation

struct StateResponseParser {
    
    func parse(_ json:Data?) -> StatesResponse?  {
        
        guard let data = json else { return nil}
        let jsonDecoder = JSONDecoder()
        do {
            let stateResponse = try jsonDecoder.decode(StatesResponse.self, from: data)
            return stateResponse
        }catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
