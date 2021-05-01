//
//  ApiClient.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation

struct URLConstants {
    static let url = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin"
}

class APIClient {
    let parser: AppointmentResponseParser
    init(_ parser: AppointmentResponseParser) {
        self.parser = parser
    }
    
    func checkForAvailableSessions(_ params:[String:String], _ completion:
                                    ((AppointmentResponse?)  ->Void)? ) {
        
        guard let url = self.getEncodedAppointmentURL(with: params) else { return }
          
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        let sessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            let validResponse = self.parser.parse(data)
            let string = String(data: data, encoding: .utf8)
            print(string)
            completion?(validResponse)
        }
        sessionTask.resume()
    }
    
    private func getEncodedAppointmentURL(with params:[String:String]) -> URL? {
        let baseUrl = URLConstants.url
        var urlComponents = URLComponents(string:baseUrl)
        let queryItems = params.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    
    
    
}
