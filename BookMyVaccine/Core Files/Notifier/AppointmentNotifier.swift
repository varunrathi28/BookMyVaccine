//
//  AppointmentNotifier.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import Foundation
import UserNotifications


class AppointmentNotifier : NSObject{
    override init() {
        super.init()
        let centre = UNUserNotificationCenter.current()
        centre.requestAuthorization(options:[.alert, .sound, .badge]) { (result, error) in
           
            if result {
                print("Permissions already granted")
            }
            else{
                print("Permissions failed")
            }
        }
        
        UNUserNotificationCenter.current().delegate  = self
    }

    func notify(for centres:[VaccineCentre]) {
        
        let bodyStr = centres.map{ $0.name}.joined(separator: "\n")
        
        let center =  UNUserNotificationCenter.current()
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = "Appointment Found"
        content.subtitle = "Centres"
        content.body = bodyStr
        content.sound = UNNotificationSound.defaultCritical

        //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:1.0, repeats: false)

        //create request to display
        let request = UNNotificationRequest(identifier: "VaccineIdentifier", content: content, trigger: trigger)
        
        print("request submitted")
        //add request to notification center
        center.add(request) { (error) in
            
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
}

extension AppointmentNotifier : UNUserNotificationCenterDelegate {

        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            completionHandler()
        }

        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound, .badge]) //required to show notification when in foreground
        }

}

