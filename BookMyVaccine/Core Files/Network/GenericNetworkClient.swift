//
//  GenericNetworkClient.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation


class GenericNetworkClient {
    
    
    open func hitNetworkRequest(url : URL, with params:[String:String]?, _ completion:
                                    ((Data?, Error?)  ->Void)? ) {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        let sessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            completion?(data,error)
        }
        sessionTask.resume()
    }
}
