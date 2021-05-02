//
//  ViewController.swift
//  BookMyVaccine
//
//  Created by VR on 01/05/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var lblSearchPreference: UILabel!
    
    var appointmentChecker: AppointmentCentre!
    var timerScheduler:TimerScheduler!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDependencies()
        setUpViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startCrawling()
        updateStatusLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerScheduler.stopCrawler()
    }
    
    func setUpViews(){
        setUpNavitionItems()
    }
    
    func updateStatusLabel(){
        lblSearchPreference.text = PreferenceManager().getSavedPreferences().description
    }
    
    func setUpNavitionItems() {
        let settingsBarButton =  UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(showPreferencesView))
        navigationItem.rightBarButtonItems = [settingsBarButton]
    }
    
    func configureDependencies() {
        let parser = AppointmentResponseParser()
        let notifier = AppointmentNotifier()
        let validator = AppointmentValidator()
        let crawlConfig = ParameterConfig()
        let apiClient = AppointmentAPIClient(parser, config: crawlConfig)
        self.appointmentChecker = AppointmentCentre(apiClient, validator, notifier)
    }
    func startCrawling(){
        self.timerScheduler = TimerScheduler(ConfigConstants.crawlFreqency, target: self.appointmentChecker, selector: #selector(AppointmentCentre.checkAppointments), params: ParameterConfig(), repeats: true)
        
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
    
   @objc func showPreferencesView() {
        let vcKey = String(describing: ConfigViewController.self)
        let preferenceVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: vcKey)
        self.navigationController?.pushViewController(preferenceVC, animated: true)
    }
    
}

