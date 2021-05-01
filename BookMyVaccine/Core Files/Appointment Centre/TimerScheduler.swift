//
//  TimerScheduler.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import UIKit

class TimerScheduler {
    private let frequency: TimeInterval
    private let target: AnyObject
    private let selector:Selector
    private let shouldRepeat:Bool
    private let params:Any?
    private var timer:Timer?
    
    init(_ frequency:TimeInterval, target: AnyObject, selector: Selector, params:Any?, repeats:Bool) {
        self.frequency = frequency
        self.target = target
        self.selector = selector
        self.shouldRepeat = repeats
        self.params = params
        self.startCrawler()
    }
    
    public func startCrawler(){
        self.timer = Timer.scheduledTimer(timeInterval: frequency, target: target, selector: selector, userInfo: self.params, repeats: shouldRepeat)
        self.timer?.fire()
    }
    
    public func stopCrawler() {
        self.timer?.invalidate()
    }
}
