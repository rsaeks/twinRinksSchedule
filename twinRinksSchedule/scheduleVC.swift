//
//  FirstViewController.swift
//  twinRinksSchedule
//
//  Created by Randy Saeks on 11/13/17.
//  Copyright © 2017 Randy Saeks. All rights reserved.
//

import UIKit
import Fuzi
import Alamofire
import KeychainSwift

// Defaults
let defaults = UserDefaults()

// Blank HTML variable to hold our respones
var html = ""

// Number of Leagues
let numberOfLeagues = leagues.count - 1

// Saved info
let keychain = KeychainSwift()

// Create our Dispatch Groups for Queue Handling of schedule requests
let lookupScheduleQueue = DispatchGroup(), lookupLeisureQueue = DispatchGroup(), lookupBronzeQueue = DispatchGroup(), lookupSilvereQueue = DispatchGroup(), lookupGoldQueue = DispatchGroup(), lookupDiamondQueue = DispatchGroup()

// Setup our storage
var allGames = games(), myGames = games()
var leagueGames = schedule(), playerGames = schedule()
var tempArray = [String]()
var skater = profile()
var sampleDates = [String]()

// League Data begins here
var leisure = schedule(), bronze = schedule(),  silver = schedule(), gold = schedule(), platinum = schedule(), diamond = schedule()
var leisureHTML = "", bronzeHTML = "", silverHTML = "", goldHTML = "", platinumHTML = "", diamondHTML = ""

// Setup our Date formatter
let rinkDateFormat = DateFormatter()

// Debug varibles
var myTeamColor: CGColor = White

var showPastGames = false

class scheduleController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var playerLeagueLabel: UILabel!
    @IBOutlet weak var giantLabel: UILabel!
    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var showPastGamesSwitch: UISwitch!
    
    override func viewDidLoad() {
//        print("View did load")
        super.viewDidLoad()
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        //print("\(player.shared.league)")
        if let savedLeague1 = defaults.string(forKey: "savedLeague1") {
            player.shared.teamData[0].league = savedLeague1
        }
        if let savedTeam1 = defaults.string(forKey: "savedTeam1") {
            player.shared.teamData[0].team = savedTeam1
           // Set our cell background colors
        }
        if let savedShowStatus = defaults.string(forKey: "savedShowPastGames") {
            print("Saved show past games is: \(savedShowStatus)")
            if savedShowStatus == "0" {
                showPastGames = false
            }
            else {
                showPastGames = true
            }
        }
        
        for x in 0..<numberOfLeagues {
            Alamofire.request(leagueScheduleURLs[x], method: .get)
                .validate(statusCode: 200..<300)
                .responseString { response in
                    if (response.result.error == nil) {
                        if x == 0 { self.formatData(theData: response.value!, theLeague: leisure, debugLeague: "Leisure") }
                        else if x == 1 { self.formatData(theData: response.value!, theLeague: bronze, debugLeague: "Bronze") }
                        else if x == 2 { self.formatData(theData: response.value!, theLeague: silver, debugLeague: "Silver") }
                        else if x == 3 { self.formatData(theData: response.value!, theLeague: gold, debugLeague: "Gold") }
                        else if x == 4 { self.formatData(theData: response.value!, theLeague: platinum, debugLeague: "Platinum") }
                        else if x == 5 { self.formatData(theData: response.value!, theLeague: diamond, debugLeague: "Diamond") }
                        else { print("Not sure why we are here ...") }
                    }
                    else { debugPrint("HTTP Request failed: \(String(describing: response.result.error))") }
            }
    }
}
    
    override func viewDidAppear(_ animated: Bool) {
//        print("View did appear")
        print("\(player.shared.league)")
        if let savedLeague1 = defaults.string(forKey: "savedLeague1") { player.shared.teamData[0].league = savedLeague1 }
        if let savedTeam1 = defaults.string(forKey: "savedTeam1") { player.shared.teamData[0].team = savedTeam1 }
        switch player.shared.teamData[0].team    {
        case "Black": myTeamColor = Black
        case "Blue": myTeamColor = Blue
        case "Brass": myTeamColor = Brass
        case "Brown": myTeamColor = Brown
        case "Copper": myTeamColor = Copper
        case "Gold": myTeamColor = Gold
        case "Grey": myTeamColor = Grey
        case "Kelly": myTeamColor = Kelly
        case "Lime": myTeamColor = Lime
        case "Orange": myTeamColor = Orange
        case "Purple": myTeamColor = Purple
        case "Red": myTeamColor = Red
        case "Royal": myTeamColor = Royal
        case "Tan": myTeamColor = Tan
        case "Teal": myTeamColor = Teal
        case "White": myTeamColor = White
        case "Yellow": myTeamColor = Yellow
        default: myTeamColor = White
        }
        print("Saved data is: \(player.shared.teamData)")
        if let savedUsername = defaults.string(forKey: "savedUsername") {
            let loginUsername = savedUsername
            print("Saved Username is: \(loginUsername)")
        }
        else { print("No saved username present") }
        
        if let savedPassword = keychain.get("savedPassword") {
            let loginPassword = savedPassword
            print("Saved Password is: \(loginPassword)")
        }
        else { print("No saved password present") }
        self.preparePlayerTeams()
    }

    func preparePlayerTeams() {
        
        print("Number of items in player array: \(player.shared.teamData.count)")
        for x in 0..<player.shared.teamData.count {
            self.playerLeagueLabel.text = player.shared.teamData[x].league + " " + player.shared.teamData[x].team
            if player.shared.teamData[x].team != "Select team"{
                playerGames.gameData.removeAll()
                switch player.shared.teamData[x].league {
                case "Leisure":
                    makePlayerSchedule(playerLeague: player.shared.teamData[x].league, playerTeam: player.shared.teamData[x].team, leagueSchedule: leisure)
                case "Bronze":
                    makePlayerSchedule(playerLeague: player.shared.teamData[x].league, playerTeam: player.shared.teamData[x].team, leagueSchedule: bronze)
                case "Silver":
                    makePlayerSchedule(playerLeague: player.shared.teamData[x].league, playerTeam: player.shared.teamData[x].team, leagueSchedule: silver)
                case "Gold":
                    makePlayerSchedule(playerLeague: player.shared.teamData[x].league, playerTeam: player.shared.teamData[x].team, leagueSchedule: gold)
                case "Platinum":
                    makePlayerSchedule(playerLeague: player.shared.teamData[x].league, playerTeam: player.shared.teamData[x].team, leagueSchedule: platinum)
                case "Diamond":
                    makePlayerSchedule(playerLeague: player.shared.teamData[x].league, playerTeam: player.shared.teamData[x].team, leagueSchedule: diamond)
                default:
                    print("Other")
                }
            }
        }
    }

    
    func formatData(theData: String, theLeague: schedule, debugLeague: String) {
        //print("================================================================")
        //print("Working on data for: \(debugLeague)")
        tempArray.removeAll()
        do {
            let doc = try HTMLDocument(string: theData, encoding: String.Encoding.utf8)
            for td in doc.css("td") {
                let temp = String(describing: td)
                tempArray.append(temp)
            }
            let gamesOnline = tempArray.count / 7
            for x in 0..<gamesOnline {
                theLeague.gameData.append((gameDate: tempArray[(7*x)], gameDayOfWeek: tempArray[(7*x)+1], gameRink: tempArray[(7*x)+2], gameTime: tempArray[(7*x)+3], gameLeague: tempArray[(7*x)+4], gameHomeTeam: tempArray[(7*x)+5], gameAwayTeam: tempArray[(7*x)+6]))
            }
            //print("Processed a total number of \(theLeague.gameData.count) games for \(debugLeague)")
            
            for x in 0..<theLeague.gameData.count {
                theLeague.gameData[x].gameDate = theLeague.gameData[x].gameDate.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameDate = theLeague.gameData[x].gameDate.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameTime = theLeague.gameData[x].gameTime.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameTime = theLeague.gameData[x].gameTime.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameRink = theLeague.gameData[x].gameRink.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameRink = theLeague.gameData[x].gameRink.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameDayOfWeek = theLeague.gameData[x].gameDayOfWeek.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameDayOfWeek = theLeague.gameData[x].gameDayOfWeek.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameHomeTeam = theLeague.gameData[x].gameHomeTeam.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameHomeTeam = theLeague.gameData[x].gameHomeTeam.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameHomeTeam = theLeague.gameData[x].gameHomeTeam.capitalized
                theLeague.gameData[x].gameAwayTeam = theLeague.gameData[x].gameAwayTeam.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameAwayTeam = theLeague.gameData[x].gameAwayTeam.replacingOccurrences(of: "</td>", with: "")
                theLeague.gameData[x].gameAwayTeam = theLeague.gameData[x].gameAwayTeam.capitalized
                theLeague.gameData[x].gameLeague = theLeague.gameData[x].gameLeague.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameLeague = theLeague.gameData[x].gameLeague.replacingOccurrences(of: "</td>\n", with: "")
            }
    
            var lCounter = 0,  bCounter = 0,  sCounter = 0, gCounter = 0, pCounter = 0, dCounter = 0

            for x in 0..<theLeague.gameData.count
            {
            switch theLeague.gameData[x].gameLeague {
            case "Leisure":
                lCounter += 1
//                let leisureHomeNameToClean = theLeague.gameData[x].gameHomeTeam.lowercased()
//                let leisureAwayNameToClean = theLeague.gameData[x].gameAwayTeam.lowercased()
                
                leisureTeams.insert(theLeague.gameData[x].gameHomeTeam.capitalized)
                leisureTeams.insert(theLeague.gameData[x].gameAwayTeam.capitalized)
                
//                for z in 0..<cleanupTeamItems.count {
//                    if leisureHomeNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { leisureTeams.insert(leisureHomeNameToClean) }
//                    if leisureAwayNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { leisureTeams.insert(leisureAwayNameToClean) }
//                }
                
                
                if lCounter == theLeague.gameData.count {
//                    print("Leisure teams before cleanup: \(leisureTeams)")
                    let filteredTeams = leisureTeams.filter({ teamName -> Bool in
                        cleanupTeamItems.contains(where: { teamName.contains($0) }) == false
                    })
                    leisureTeams = cleanUpSchedule(theLeagueTeams: filteredTeams, debugLeague: "Leisure")
//                    print("Leisure teams after cleanup: \(leisureTeams)")
                }

            case "Bronze":
                bCounter += 1
//                let bronzeHomeNameToClean = theLeague.gameData[x].gameHomeTeam.lowercased()
//                let bronzeAwayNameToClean = theLeague.gameData[x].gameAwayTeam.lowercased()
                bronzeTeams.insert(theLeague.gameData[x].gameHomeTeam.capitalized)
                bronzeTeams.insert(theLeague.gameData[x].gameAwayTeam.capitalized)
 
//                for z in 0..<cleanupTeamItems.count {
//                    if bronzeHomeNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { bronzeTeams.insert(bronzeHomeNameToClean) }
//                    if bronzeAwayNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { bronzeTeams.insert(bronzeAwayNameToClean) }
//                }
                
                if bCounter == theLeague.gameData.count {
//                    print("Bronze teams before cleanup: \(bronzeTeams)")
                    let filteredTeams = bronzeTeams.filter({ teamName -> Bool in
                        cleanupTeamItems.contains(where: { teamName.contains($0) }) == false
                    })
                    bronzeTeams = cleanUpSchedule(theLeagueTeams: filteredTeams, debugLeague: "Bronze")
//                    print("Bronze teams after cleanup: \(bronzeTeams)")
                }
                
            case "Silver":
                sCounter += 1
//                let silverHomeNameToClean = theLeague.gameData[x].gameHomeTeam.lowercased()
//                let silverAwayNameToClean = theLeague.gameData[x].gameAwayTeam.lowercased()
//
                silverTeams.insert(theLeague.gameData[x].gameHomeTeam.capitalized)
                silverTeams.insert(theLeague.gameData[x].gameAwayTeam.capitalized)
                
//                for z in 0..<cleanupTeamItems.count {
//                    if silverHomeNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { silverTeams.insert(silverHomeNameToClean) }
//                    if silverAwayNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { silverTeams.insert(silverAwayNameToClean) }
//                }
//
                if sCounter == theLeague.gameData.count {
//                    print("Silver teams before cleanup: \(silverTeams)")
                    let filteredTeams = silverTeams.filter({ teamName -> Bool in
                        cleanupTeamItems.contains(where: { teamName.contains($0) }) == false
                    })
                    silverTeams = cleanUpSchedule(theLeagueTeams: filteredTeams, debugLeague: "Silver")
//                    print("Silver teams after cleanup: \(silverTeams)")
                }
            
            case "Gold":
                gCounter += 1
//                let goldHomeNameToClean = theLeague.gameData[x].gameHomeTeam.lowercased()
//                let goldAwayNameToClean = theLeague.gameData[x].gameAwayTeam.lowercased()
                
                goldTeams.insert(theLeague.gameData[x].gameHomeTeam.capitalized)
                goldTeams.insert(theLeague.gameData[x].gameAwayTeam.capitalized)
                
//                for z in 0..<cleanupTeamItems.count {
//                    if goldHomeNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { goldTeams.insert(goldHomeNameToClean) }
//                    if goldAwayNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { goldTeams.insert(goldAwayNameToClean) }
//                }
                
                if gCounter == theLeague.gameData.count {
//                    print("Gold teams before cleanup: \(goldTeams)")
                    let filteredTeams = goldTeams.filter({ teamName -> Bool in
                        cleanupTeamItems.contains(where: { teamName.contains($0) }) == false
                    })
                    goldTeams = cleanUpSchedule(theLeagueTeams: filteredTeams, debugLeague: "Gold")
//                    print("Gold teams after cleanup: \(goldTeams)")
                }
                
            case "Platinum":
                pCounter += 1
//                let platinumHomeNameToClean = theLeague.gameData[x].gameHomeTeam.lowercased()
//                let platinumAwayNameToClean = theLeague.gameData[x].gameAwayTeam.lowercased()
                
                platinumTeams.insert(theLeague.gameData[x].gameHomeTeam.capitalized)
                platinumTeams.insert(theLeague.gameData[x].gameAwayTeam.capitalized)
               
//                for z in 0..<cleanupTeamItems.count {
//                    if platinumHomeNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { platinumTeams.insert(platinumHomeNameToClean) }
//                    if platinumAwayNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { platinumTeams.insert(platinumAwayNameToClean) }
//                }
             
                if pCounter == theLeague.gameData.count {
//                    print("Platinum teams before cleanup: \(platinumTeams)")
                    let filteredTeams = platinumTeams.filter({ teamName -> Bool in
                        cleanupTeamItems.contains(where: { teamName.contains($0) }) == false
                    })
                    platinumTeams = cleanUpSchedule(theLeagueTeams: filteredTeams, debugLeague: "Platinum")
//                    print("Platinum teams after cleanup: \(platinumTeams)")
                }
                
            case "Diamond":
                dCounter += 1
//                let diamondHomeNameToClean = theLeague.gameData[x].gameHomeTeam.lowercased()
//                let diamondAwayNameToClean = theLeague.gameData[x].gameAwayTeam.lowercased()
                
                diamondTeams.insert(theLeague.gameData[x].gameHomeTeam.capitalized)
                diamondTeams.insert(theLeague.gameData[x].gameAwayTeam.capitalized)
                

//                for z in 0..<cleanupTeamItems.count {
//                    if diamondHomeNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { diamondTeams.insert(diamondHomeNameToClean) }
//                    if diamondAwayNameToClean.contains(cleanupTeamItems[z]) { }
//                    else { diamondTeams.insert(diamondAwayNameToClean) }
//                }
                
                if dCounter == theLeague.gameData.count {
//                    print("Diamond teams before cleanup: \(diamondTeams)")
                    let filteredTeams = diamondTeams.filter({ teamName -> Bool in
                        cleanupTeamItems.contains(where: { teamName.contains($0) }) == false
                    })
                    diamondTeams = cleanUpSchedule(theLeagueTeams: filteredTeams, debugLeague: "Diamond")
//                    print("Diamond teams after cleanup: \(diamondTeams)")
                    let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) { self.preparePlayerTeams() }
                }

            default:
                break
            }
            }
        } catch let error {
            print(error)
        }
    }
    
    func cleanUpSchedule(theLeagueTeams: Set<String>, debugLeague: String) -> Set<String> {
        //print("Cleaning up schedule for \(debugLeague)")
        var teamsToClean = theLeagueTeams
        for x in 0..<cleanup.count {
            teamsToClean.remove(cleanup[x])
        }
        //print("Total number of teams in \(debugTeam) is \(teamsToClean.count)")
        //print("List of teams: \(teamsToClean)")
        return teamsToClean
    }
    
    func makePlayerSchedule(playerLeague: String, playerTeam: String, leagueSchedule: schedule)
    {
        print("Total games to process: \(leagueSchedule.gameData.count)")
        for x in 0..<leagueSchedule.gameData.count {
            if leagueSchedule.gameData[x].gameHomeTeam.contains(playerTeam) || leagueSchedule.gameData[x].gameAwayTeam.contains(playerTeam) {
                // Working on Date formatting
                // Store in SampleDates array
                
                rinkDateFormat.dateFormat = "M/d/yyyy"
                let d1 = rinkDateFormat.date(from: leagueSchedule.gameData[x].gameDate)
                //let d2 = Date()
                let now = Date()
                let d2 = Calendar.current.date(byAdding: .day, value: -1, to: now)
                //let s2 = rinkDateFormat.string(from: d2!)
                //print("Game date is: \(d1!) and Current Date is: \(d2)")
                if d1! > d2! {
                    //print("Game date is in the future ... we should show")
                    playerGames.gameData.append(leagueSchedule.gameData[x])
                    sampleDates.append(leagueSchedule.gameData[x].gameDate)
                    //print("On \(leagueSchedule.gameData[x].gameDayOfWeek) \(leagueSchedule.gameData[x].gameDate) at \(leagueSchedule.gameData[x].gameTime) on the \(leagueSchedule.gameData[x].gameRink) rink \(leagueSchedule.gameData[x].gameHomeTeam) is playing against \(leagueSchedule.gameData[x].gameAwayTeam)")
                }
                else {
                    //print("Game date is in the past ... we should hide")
                    if showPastGames { playerGames.gameData.append(leagueSchedule.gameData[x]) }
                }
                
                

            }
            else if leagueSchedule.gameData[x].gameHomeTeam.contains(PLAYOFFString) || leagueSchedule.gameData[x].gameHomeTeam.contains(SEMI_FINALString) || leagueSchedule.gameData[x].gameHomeTeam.contains(FINALString) {
                // Working on Date formatting
                // Store in SampleDates array
                rinkDateFormat.dateFormat = "M/d/yyyy"
                let d1 = rinkDateFormat.date(from: leagueSchedule.gameData[x].gameDate)
                //let d2 = Date()
                let now = Date()
                let d2 = Calendar.current.date(byAdding: .day, value: -1, to: now)
                //let s2 = rinkDateFormat.string(from: d2!)
                //print("Game date is: \(d1!) and Current Date is: \(d2)")
                if d1! > d2! {
                    //print("Playoff date is in the future ... we should show")
                    playerGames.gameData.append(leagueSchedule.gameData[x])
                    sampleDates.append(leagueSchedule.gameData[x].gameDate)
                    //print("On \(leagueSchedule.gameData[x].gameDayOfWeek) \(leagueSchedule.gameData[x].gameDate) at \(leagueSchedule.gameData[x].gameTime) on the \(leagueSchedule.gameData[x].gameRink) rink \(leagueSchedule.gameData[x].gameHomeTeam) is playing against \(leagueSchedule.gameData[x].gameAwayTeam)")
                }
                else {
                    //print("Playoff date is in the past ... we should hide")
                    if showPastGames { playerGames.gameData.append(leagueSchedule.gameData[x]) }
                }
            }
        }
        print("Total number of games found for the player: \(playerGames.gameData.count)")
        
        var allGamesLabel = ""
        
        for x in 0..<playerGames.gameData.count {
        allGamesLabel = allGamesLabel + playerGames.gameData[x].gameLeague + " " + playerGames.gameData[x].gameDayOfWeek + " " + playerGames.gameData[x].gameDate + " " + playerGames.gameData[x].gameTime + " " + playerGames.gameData[x].gameRink + " " + playerGames.gameData[x].gameHomeTeam + " " + playerGames.gameData[x].gameAwayTeam + "\n"
        }
        
        //giantLabel.text = allGamesLabel
        self.scheduleTableView.reloadData()
        
        // Setup our date format here
//        rinkDateFormat.dateFormat = "M/d/yyyy"
//        let d2 = Date()
//        let s2 = rinkDateFormat.string(from: d2)
//        for d in 0..<sampleDates.count {
//            let d1 = rinkDateFormat.date(from:sampleDates[d])
//            if d1! > d2 {
//            }
//            else {
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("TableView - number of runs in section is: \(playerGames.gameData.count)")
        return playerGames.gameData.count
    }
    
    @IBAction func showPastGamesToggled(_ sender: Any) {
            showPastGames = showPastGamesSwitch.isOn
            defaults.set(showPastGames, forKey: "savedShowPastGames")
            print("Switch is \(showPastGames)")
            self.preparePlayerTeams()
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as? ScheduleTableViewCell {
           cell.updateViews(leagueImage: playerGames.gameData[indexPath.row].gameLeague,
                            homeTeam: playerGames.gameData[indexPath.row].gameHomeTeam,
                            date: playerGames.gameData[indexPath.row].gameDate,
                            dayOfWeek: playerGames.gameData[indexPath.row].gameDayOfWeek,
                            time: playerGames.gameData[indexPath.row].gameTime,
                            awayTeam: playerGames.gameData[indexPath.row].gameAwayTeam,
                            rink: playerGames.gameData[indexPath.row].gameRink)
//            print("Updating table view cell at position: \(indexPath.row)")
//            print("Data is as follows:")
//            print("League : \(playerGames.gameData[indexPath.row].gameLeague)")
//            print("Home Team: \(playerGames.gameData[indexPath.row].gameHomeTeam)")
//            print("date: \(playerGames.gameData[indexPath.row].gameDate)")
//            print("day of week: \(playerGames.gameData[indexPath.row].gameDayOfWeek)")
//            print("time: \(playerGames.gameData[indexPath.row].gameTime)")
//            print("away team: \(playerGames.gameData[indexPath.row].gameAwayTeam)")
//            print("rink: \(playerGames.gameData[indexPath.row].gameRink)")
            if playerGames.gameData[indexPath.row].gameRink == "Blue" {
                cell.backgroundColor = BlueRink
                cell.layer.borderWidth = 4
                cell.layer.borderColor = myTeamColor
            }
            else if playerGames.gameData[indexPath.row].gameRink == "Red"{
                cell.backgroundColor = RedRink
                cell.layer.borderWidth = 4
                cell.layer.borderColor = myTeamColor
            }
            return cell
        }
        else { return ScheduleTableViewCell() }
    }
}
