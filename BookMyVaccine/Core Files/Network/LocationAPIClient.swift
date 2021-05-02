//
//  LocationAPIClient.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation


class LocationAPIClient: GenericNetworkClient {
    
    enum RequestType:Int{
        case fetchState, fetchDistrict
    }
    
    private let baseURL = "https://cdn-api.co-vin.in/api/v2/admin/location/"
    private let statePath = "states"
    private let districtPath = "districts/"
    
    let districtParser: DistrictResponseParser
    let stateParser:StateResponseParser
    
    init(_ stateParser: StateResponseParser = StateResponseParser(), _ districtParser: DistrictResponseParser = DistrictResponseParser()) {
        self.stateParser = stateParser
        self.districtParser = districtParser
    }

    private func getStrURL(for requestType:RequestType)-> String{
        var url = self.baseURL
        if requestType == .fetchDistrict {
            url += districtPath
        }
        else{
            url += statePath
        }
        return url
    }
    
    func fetchStatesList(_ completion: @escaping (StatesResponse?)-> Void ) {
        
        guard let url = URL(string: getStrURL(for: .fetchState)) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.hitNetworkRequest(url: url, with: nil) { [weak self](data, error) in
                guard let data = data, let self = self  else {
                    completion(nil)
                    return
                }
                let stateResponse = self.stateParser.parse(data)
                DispatchQueue.main.async {
                    completion(stateResponse)
                }
            }
        }
    }
    
    func fetchDistricts(for stateID:Int, completion: @escaping (DistrictResponse?) -> Void){
        let completeURL = getStrURL(for: .fetchDistrict) + "\(stateID)"
        guard let url = URL(string: completeURL) else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.hitNetworkRequest(url: url, with: nil) {[weak self] (data, error) in
                guard let data = data, let self = self  else {
                    completion(nil)
                    return
                }
                
                let districtResponse = self.districtParser.parse(data)
                DispatchQueue.main.async {
                    completion(districtResponse)
                }
            }
        }
            
    }

}
