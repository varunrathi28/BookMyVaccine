//
//  ConfigViewController.swift
//  BookMyVaccine
//
//  Created by VR on 02/05/21.
//

import UIKit

class ConfigViewController: UIViewController {

    @IBOutlet var segmentedControl : UISegmentedControl!
    @IBOutlet var containerView : UIView!
    @IBOutlet var pincodeView : UIView!
    @IBOutlet var districtView : UIView!
    @IBOutlet var buttonSave : UIButton!
    @IBOutlet var textfieldPincode : UITextField!
    @IBOutlet var textfieldDistrict : UITextField!
    @IBOutlet var textfieldState : UITextField!

    var stateDistrictMap = [State : [District]]()
    
    var statePickerView : UIPickerView = {
        let pickerView =   UIPickerView()
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    let districtPickerView : UIPickerView = {
       return UIPickerView()
    }()

    var selectedTextFieldIdx: Int = 0
    
    var selectedDistrict:District? {
        didSet {
            textfieldDistrict.text = selectedDistrict?.district_name
        }
    }
    var selectedState:State? {
        didSet {
            textfieldState.text = selectedState?.state_name
        }
    }
    
    var stateList : [State]  = []
    let apiClient = LocationAPIClient(StateResponseParser())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePreviousPreferences()
    }
    
    func setUpViews() {
        textfieldState.inputView = statePickerView
        textfieldDistrict.inputView = districtPickerView
        statePickerView.delegate = self
        statePickerView.dataSource = self
        districtPickerView.delegate = self
        districtPickerView.dataSource = self
        textfieldPincode.delegate = self
        textfieldDistrict.delegate = self
        textfieldState.delegate = self
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    func updatePreviousPreferences(){
        let userPref = PreferenceManager().getSavedPreferences()
        textfieldPincode.text = userPref.selectedPincode?.string_rep
        textfieldState.text = userPref.selectedStateID?.string_rep
        textfieldDistrict.text = userPref.selectedDistrictID?.string_rep
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        view.endEditing(true)
        
        if sender.selectedSegmentIndex == 0 {
            pincodeView.isHidden = false
            districtView.isHidden = true
        }
        else{
            pincodeView.isHidden = true
            districtView.isHidden = false
            fetchStates()
        }
    }
    
    func fetchStates(){
        guard self.stateList.isEmpty else { return }
 
        apiClient.fetchStatesList { (response) in
            guard let response = response else { return }
            self.stateList = response.states
            self.refreshData {
               // self.pickerView.reloadAllComponents()
            }
        }
    }
    
    func fetchDistricts(for state:State) {
        
        guard let selectedState = selectedState, stateDistrictMap[selectedState] == nil  else {
            return
        }
        
        apiClient.fetchDistricts(for: state.state_id) { (response) in
            guard let response = response else { return }
            self.stateDistrictMap[state] = response.districts
            self.refreshData {
                self.districtPickerView.reloadAllComponents()
            }
        }
    }
    
    func refreshData(_ completion:@escaping ()-> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
    
    @IBAction func buttonSaveClicked() {
        let searchByType = SearchByType(rawValue:segmentedControl.selectedSegmentIndex
        )!
        
        let selectedPincode = Int(textfieldPincode.text ?? "")
        let selectedPreferences = UserPreferences(searchType: searchByType, selectedPincode: selectedPincode, selectedDistrictID: selectedDistrict?.district_id, selectedStateID: selectedState?.state_id)
        PreferenceManager().saveUserPreferences(selectedPreferences)
    }
}

extension ConfigViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePickerView {
            return stateList.count
        }
        else{
            guard let state = selectedState , let  districtArr = stateDistrictMap[state] else {
                return 0
            }
            return districtArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == statePickerView {
            return stateList[row].state_name
        }
        else{
            guard  let state = selectedState, let districtList = stateDistrictMap[state] else {
                return nil
            }
            return districtList[row].district_name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePickerView {
            selectedState = stateList[row]
            textfieldState.resignFirstResponder()
            fetchDistricts(for: stateList[row])
            selectedDistrict = nil
        }
        
        else if pickerView == districtPickerView {
            if let selectedState = selectedState, let districtArr = stateDistrictMap[selectedState] {
                selectedDistrict = districtArr[row]
                textfieldDistrict.resignFirstResponder()
            }
        }
    }
}


extension ConfigViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

}
