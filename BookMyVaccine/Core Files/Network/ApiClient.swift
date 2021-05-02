//
//  ApiClient.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation



 class AppointmentAPIClient : GenericNetworkClient{
    let parser: AppointmentResponseParser
    let parameterConfig:ParameterConfig
    init(_ parser: AppointmentResponseParser, config:ParameterConfig = ParameterConfig()) {
        self.parser = parser
        self.parameterConfig = config
    }
    
    func checkForAvailableSessions(searchBy searchType:SearchByType, _ completion:
                                    ((AppointmentResponse?)  ->Void)? ) {
        
        let bodyParams = self.parameterConfig.getBody(for: searchType)
        guard let url = self.getEncodedAppointmentURL(for: searchType, with: bodyParams) else { return }
        
        self.hitNetworkRequest(url: url, with: nil) { (data , error) in
            guard let data = data else {
                completion?(nil)
                return
            }
            
            let validResponse = self.parser.parse(data)
            let string = String(data: data, encoding: .utf8)
            completion?(validResponse)
        }
    }
    
    private func getEncodedAppointmentURL(for searchType:SearchByType, with params:[String:String]) -> URL? {
        var baseUrl = URLConstants.baseURL
    
        if searchType == .searchByPincode {
            baseUrl = baseUrl.appending(URLConstants.pathPincode)
        }
        else{
            baseUrl = baseUrl.appending(URLConstants.pathDistrict)
        }
        
        var urlComponents = URLComponents(string:baseUrl)
        let queryItems = params.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
