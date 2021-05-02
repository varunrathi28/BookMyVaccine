//
//  AlarmController.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import Foundation
import EventKit

struct AlarmController {
    
    func setUpAlarm(){
        return
        var store:EKEventStore = EKEventStore()
       
        
        store.requestAccess(to: EKEntityType.event) { (granted, error) in
                                            
                                            if let e = error {
                                                print("Error \(e.localizedDescription)")
                                            }
                                            
                                            if granted {
                                                print("access granted")
                                                
                                                let date = Date()
                                                var event:EKEvent = EKEvent(eventStore: store)
                                                event.title = "Someone's birthday"
                                                event.startDate = date
                                                event.endDate = date
                                                event.isAllDay = true
                                                event.calendar = store.defaultCalendarForNewEvents
                                                // 60 seconds before
                                                var alarm:EKAlarm = EKAlarm(relativeOffset: -60)
                                                event.alarms = [alarm]
                                                
                                                var err:NSError?
                                                do {
                                                try store.save(event, span:EKSpan.thisEvent)
                                                }
                                                catch {
                                                    print("could not save \(error.localizedDescription)")
                                                }
                                               
                                            }
                                        }
    }
}


