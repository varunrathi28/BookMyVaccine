//
//  Parseable.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation

protocol Parseable {
    associatedtype ModelType
    
    func parse(_ json:Data?) -> ModelType
}
