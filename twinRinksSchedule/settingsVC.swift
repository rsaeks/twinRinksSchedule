//
//  settingsVC.swift
//  twinRinksSchedule
//
//  Created by Randy Saeks on 11/13/17.
//  Copyright © 2017 Randy Saeks. All rights reserved.
//

import UIKit
import Alamofire

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
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return leagueTeam.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return leagueTeam[component].count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return leagueTeam[component][row]
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
                let leisureArray = Array(leisureTeams)
                leagueTeam = [leagues,leisureArray.sorted{ $0 < $1} ]
                self.teamOnePicker.reloadComponent(1)
            }
            else if row == 2 {
                selectedLeague = "Bronze"
                let bronzeArray = Array(bronzeTeams)
                leagueTeam = [leagues,bronzeArray.sorted{ $0 < $1} ]
                self.teamOnePicker.reloadComponent(1)
            }
            else if row == 3 {
                selectedLeague = "Silver"
                let silverArray = Array(silverTeams)
                leagueTeam = [leagues,silverArray.sorted{ $0 < $1} ]
                self.teamOnePicker.reloadComponent(1)
            }
            else if row == 4 {
                selectedLeague = "Gold"
                let goldArray = Array(goldTeams)
                leagueTeam = [leagues,goldArray.sorted{ $0 < $1} ]
                self.teamOnePicker.reloadComponent(1)
            }
            else if row == 5 {
                selectedLeague = "Platinum"
                let platinumArray = Array(platinumTeams)
                leagueTeam = [leagues,platinumArray.sorted{ $0 < $1} ]
                self.teamOnePicker.reloadComponent(1)
            }
            else if row == 6 {
                selectedLeague = "Diamond"
                let diamondArray = Array(diamondTeams)
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
        //print("Selected League: \(leagueTeam[component][row])")
            //print("Selected League is: \(selectedLeague)")
        
        //print("Selected info at row \(leagueTeam[component][row])")
        
        //defaults.set(leagues[row], forKey: "savedLeague")
        //player.shared.league = leagues[row]
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.teamOnePicker.dataSource = self
        self.teamOnePicker.delegate = self
        if let chosenLeague1 = defaults.string(forKey: "savedLeague1") {
            for x in 0..<leagues.count {
                if leagues[x] == chosenLeague1 {
                    print("Found saved league \(leagues[x]) at index \(x)")
                    if let chosenTeam1 = defaults.string(forKey: "savedTeam1") {
                        switch chosenLeague1 {
                        case "Leisure":
                            let leisureArray = Array(leisureTeams)
                            for y in 0..<leisureArray.count {
                                if leisureArray[y] == chosenTeam1 {
                                    leagueTeam = [leagues,leisureArray.sorted{ $0 < $1} ]
                                    print("Found saved team \(chosenTeam1) at index \(y)")
                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
                                    self.teamOnePicker.reloadComponent(1)
                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
                                }
                            }
                        case "Bronze":
                            let bronzeArray = Array(bronzeTeams)
                            for y in 0..<bronzeArray.count {
                                if bronzeArray[y] == chosenTeam1 {
                                    leagueTeam = [leagues,bronzeArray.sorted{ $0 < $1} ]
                                    print("Found saved team \(chosenTeam1) at index \(y)")
                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
                                    self.teamOnePicker.reloadComponent(1)
                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
                                }
                            }
                        case "Silver":
                            let silverArray = Array(silverTeams)
                            for y in 0..<silverArray.count {
                                if silverArray[y] == chosenTeam1 {
                                    print("Found saved team \(chosenTeam1) at index \(y)")
                                    leagueTeam = [leagues,silverArray.sorted{ $0 < $1} ]
                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
                                    self.teamOnePicker.reloadComponent(1)
                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
                                }
                            }
                        case "Gold":
                            let goldArray = Array(goldTeams)
                            for y in 0..<goldArray.count {
                                if goldArray[y] == chosenTeam1 {
                                    leagueTeam = [leagues,goldArray.sorted{ $0 < $1} ]
                                    print("Found saved team \(chosenTeam1) at index \(y)")
                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
                                    self.teamOnePicker.reloadComponent(1)
                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
                                }
                            }
                        case "Platinum":
                            let platinumArray = Array(platinumTeams)
                            for y in 0..<platinumArray.count {
                                if platinumArray[y] == chosenTeam1 {
                                    leagueTeam = [leagues,platinumArray.sorted{ $0 < $1} ]
                                    print("Found saved team \(chosenTeam1) at index \(y)")
                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
                                    self.teamOnePicker.reloadComponent(1)
                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
                                }
                            }
                        case "Diamond":
                            let diamondArray = Array(diamondTeams)
                            for y in 0..<diamondArray.count {
                                if diamondArray[y] == chosenTeam1 {
                                    leagueTeam = [leagues,diamondArray.sorted{ $0 < $1} ]
                                    print("Found saved team \(chosenTeam1) at index \(y)")
                                    teamOnePicker.selectRow(x, inComponent: 0, animated: true)
                                    self.teamOnePicker.reloadComponent(1)
                                    teamOnePicker.selectRow(y, inComponent: 1, animated: true)
                                }
                            }
                        default:
                            print("Unhandled Case")
                        }
                    }
                    //print("Found saved league \(leagues[x]) at index \(x)")
                }
            }
        }
    }
}
