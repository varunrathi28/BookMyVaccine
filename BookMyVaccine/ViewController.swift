//
//  ViewController.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    var appointmentChecker: AppointmentCentre!
    var timerScheduler:TimerScheduler!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDependencies()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startCrawling()
    }
    
    func configureDependencies() {
        let parser = AppointmentResponseParser()
        let apiClient = APIClient(parser)
        let notifier = AppointmentNotifier()
        let validator = AppointmentValidator()
        self.appointmentChecker = AppointmentCentre(apiClient, validator, notifier)
    }
    func startCrawling(){
        let dic = ["pincode":VaccineCrawlerConfig.desiredPincode , "date": VaccineCrawlerConfig.desiredDate]
        self.timerScheduler = TimerScheduler(VaccineCrawlerConfig.crawlFreqency, target: self.appointmentChecker, selector: #selector(AppointmentCentre.checkAppointments), params: dic, repeats: true)
        
    }
    
    func stubData() -> Data? {
        if let path = Bundle.main.path(forResource: "Response", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
                  return data
              } catch {
                   // handle error
              }
        }
        
        return nil
    }

}

