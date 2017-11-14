//
//  settingsVC.swift
//  twinRinksSchedule
//
//  Created by Randy Saeks on 11/13/17.
//  Copyright © 2017 Randy Saeks. All rights reserved.
//

import UIKit

class settingsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var leaguePicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return leagues.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return leagues[row] }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected league at row \(leagues[row])")
        let defaults = UserDefaults()
        defaults.set(leagues[row], forKey: "savedLeague")
        player.shared.league = leagues[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leaguePicker.dataSource = self
        self.leaguePicker.delegate = self
    }
    
}
