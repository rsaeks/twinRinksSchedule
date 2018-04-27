//
//  settingsVC.swift
//  twinRinksSchedule
//
//  Created by Randy Saeks on 11/13/17.
//  Copyright © 2017 Randy Saeks. All rights reserved.
//

import UIKit
import Alamofire
import KeychainSwift

let passToSchedule = scheduleController()

class settingsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var leagueTeam = [leagues,teamsInit]
    var selectedLeague = ""
    var selectedTeam = ""
    
    let defaults = UserDefaults()
    
    
    @IBOutlet weak var numberOfTeams: UITextField!
    @IBOutlet weak var teamOnePicker: UIPickerView!
    @IBOutlet weak var teamTwoStackView: UIStackView!
    @IBOutlet weak var teamTwoPicker: UIPickerView!
    @IBOutlet weak var teamThreeStackView: UIStackView!
    @IBOutlet weak var teamThreePicker: UIPickerView!
    @IBOutlet weak var showPastGamesSwitch: UISwitch!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return leagueTeam.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return leagueTeam[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return leagueTeam[component][row]
    }
    
    @IBAction func numberOfTeamsChanged(_ sender: Any) {
        print("Now working on the following number of teams: \(numberOfTeams.text ?? "1")")
        if numberOfTeams.text == "1" {
            teamTwoStackView.isHidden = true
            teamThreeStackView.isHidden = true
        }
        else if numberOfTeams.text == "2" {
            teamTwoStackView.isHidden = false
            teamThreeStackView.isHidden = true
        }
        else if numberOfTeams.text == "3" {
            teamTwoStackView.isHidden = false
            teamThreeStackView.isHidden = false
        }
    }
    

    @IBAction func saveUsernamePassPressed(_ sender: Any) {
        defaults.set(usernameText.text, forKey: "savedUsername")
        keychain.set(passwordText.text!, forKey: "savedPassword")
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("selected League: \(component)")
        //print("selected team: \(row)")
        if pickerView.tag == 0 {
            switch (component) {
                case 0:
                    if row == 0 { selectedLeague = "" }
                    else if row == 1 {
                        //print("Selected League: \(leagueTeam[component][row])")
                        selectedLeague = "Leisure"
                        var leisureArray = Array(leisureTeams)
                        for x in 0..<leisureArray.count { leisureArray[x] = leisureArray[x].capitalized }
                        leagueTeam = [leagues,leisureArray.sorted{ $0 < $1} ]
                        self.teamOnePicker.reloadComponent(1)
                    }
                    else if row == 2 {
                        selectedLeague = "Bronze"
                        var bronzeArray = Array(bronzeTeams)
                        for x in 0..<bronzeArray.count { bronzeArray[x] = bronzeArray[x].capitalized }
                        leagueTeam = [leagues,bronzeArray.sorted{ $0 < $1} ]
                        self.teamOnePicker.reloadComponent(1)
                    }
                    else if row == 3 {
                        selectedLeague = "Silver"
                        var silverArray = Array(silverTeams)
                        for x in 0..<silverArray.count { silverArray[x] = silverArray[x].capitalized }
                        leagueTeam = [leagues,silverArray.sorted{ $0 < $1} ]
                        self.teamOnePicker.reloadComponent(1)
                    }
                    else if row == 4 {
                        selectedLeague = "Gold"
                        var goldArray = Array(goldTeams)
                        for x in 0 ..< goldArray.count { goldArray[x] = goldArray[x].capitalized }
                        leagueTeam = [leagues,goldArray.sorted{ $0 < $1} ]
                        self.teamOnePicker.reloadComponent(1)
                    }
                    else if row == 5 {
                        selectedLeague = "Platinum"
                        var platinumArray = Array(platinumTeams)
                        for x in 0..<platinumArray.count { platinumArray[x] = platinumArray[x].capitalized }
                        leagueTeam = [leagues,platinumArray.sorted{ $0 < $1} ]
                        self.teamOnePicker.reloadComponent(1)
                    }
                    else if row == 6 {
                        selectedLeague = "Diamond"
                        var diamondArray = Array(diamondTeams)
                        for x in 0..<diamondArray.count { diamondArray[x] = diamondArray[x].capitalized }
                        leagueTeam = [leagues,diamondArray.sorted{ $0 < $1} ]
                        self.teamOnePicker.reloadComponent(1)
                    }
                    print("Selected League: \(leagueTeam[component][row])")
                case 1:
                    print("Team selected: \(leagueTeam[component][row])")
                    player.shared.teamData[pickerView.tag].league = selectedLeague
                    player.shared.teamData[pickerView.tag].team = leagueTeam[component][row]
                    defaults.set(selectedLeague, forKey: "savedLeague1")
                    defaults.set(leagueTeam[component][row], forKey: "savedTeam1")
                    //player.shared.teamData.append((league:selectedLeague, team: leagueTeam[component][row]))
                default: break
                }
        }
        else if pickerView.tag == 1 {
            print("Selected Team #2 Data")
        }
        else if pickerView.tag == 2 {
            print("Selected Team #3 Data")
        }
    }
    
    @IBAction func toggledPastGames(_ sender: UISwitch) {
        showPastGames = showPastGamesSwitch.isOn
        defaults.set(showPastGames, forKey: "savedShowPastGames")
        print("Switch is \(showPastGames)")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.teamOnePicker.dataSource = self
        self.teamOnePicker.delegate = self
        self.teamTwoPicker.dataSource = self
        self.teamTwoPicker.delegate = self
        self.teamThreePicker.dataSource = self
        self.teamThreePicker.delegate = self
        
        //print("Number of teams in Bronze is: \(bronzeTeams.count)")
        
        
        if let savedShowPastGames = defaults.string(forKey: "savedShowPastGames") {
            if savedShowPastGames == "0" {
                showPastGamesSwitch.isOn = false
            }
            else {
                showPastGamesSwitch.isOn = true
            }
        }
        
        if let savedUsername = defaults.string(forKey: "savedUsername") {
            usernameText.text = savedUsername
            print("Saved Username is: \(savedUsername)")
        }
        
        if let savedPassword = keychain.get("savedPassword") {
            passwordText.text = savedPassword
            print("Saved Password is: \(savedPassword)")
        }

//        if let chosenLeague1 = defaults.string(forKey: "savedLeague1") {
//            for x in 0..<leagues.count {
//                if leagues[x] == chosenLeague1 {
//                    print("Found saved league \(leagues[x]) at index \(x)")
//                    if let chosenTeam1 = defaults.string(forKey: "savedTeam1") {
//                        switch chosenLeague1 {
//                        case "Leisure":
//                            let leisureArray = Array(leisureTeams)
//                            for y in 0..<leisureArray.count {
//                                if leisureArray[y] == chosenTeam1 {
//                                    leagueTeam = [leagues,leisureArray.sorted{ $0 < $1} ]
//                                    print("Found saved team \(chosenTeam1) at index \(y)")
//                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
//                                    self.teamOnePicker.reloadComponent(1)
//                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
//                                }
//                            }
//                        case "Bronze":
//                            let bronzeArray = Array(bronzeTeams)
//                            for y in 0..<bronzeArray.count {
//                                if bronzeArray[y] == chosenTeam1 {
//                                    leagueTeam = [leagues,bronzeArray.sorted{ $0 < $1} ]
//                                    print("Found saved team \(chosenTeam1) at index \(y)")
//                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
//                                    self.teamOnePicker.reloadComponent(1)
//                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
//                                }
//                            }
//                        case "Silver":
//                            let silverArray = Array(silverTeams)
//                            for y in 0..<silverArray.count {
//                                if silverArray[y] == chosenTeam1 {
//                                    print("Found saved team \(chosenTeam1) at index \(y)")
//                                    leagueTeam = [leagues,silverArray.sorted{ $0 < $1} ]
//                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
//                                    self.teamOnePicker.reloadComponent(1)
//                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
//                                }
//                            }
//                        case "Gold":
//                            let goldArray = Array(goldTeams)
//                            for y in 0..<goldArray.count {
//                                if goldArray[y] == chosenTeam1 {
//                                    leagueTeam = [leagues,goldArray.sorted{ $0 < $1} ]
//                                    print("Found saved team \(chosenTeam1) at index \(y)")
//                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
//                                    self.teamOnePicker.reloadComponent(1)
//                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
//                                }
//                            }
//                        case "Platinum":
//                            let platinumArray = Array(platinumTeams)
//                            for y in 0..<platinumArray.count {
//                                if platinumArray[y] == chosenTeam1 {
//                                    leagueTeam = [leagues,platinumArray.sorted{ $0 < $1} ]
//                                    print("Found saved team \(chosenTeam1) at index \(y)")
//                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
//                                    self.teamOnePicker.reloadComponent(1)
//                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
//                                }
//                            }
//                        case "Diamond":
//                            let diamondArray = Array(diamondTeams)
//                            for y in 0..<diamondArray.count {
//                                if diamondArray[y] == chosenTeam1 {
//                                    leagueTeam = [leagues,diamondArray.sorted{ $0 < $1} ]
//                                    print("Found saved team \(chosenTeam1) at index \(y)")
//                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
//                                    self.teamOnePicker.reloadComponent(1)
//                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
//                                }
//                            }
//                        default:
//                            print("Unhandled Case")
//                        }
//                    }
                    //print("Found saved league \(leagues[x]) at index \(x)")
//                }
//            }
//        }
    }
}
