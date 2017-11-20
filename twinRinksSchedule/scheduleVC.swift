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

// Defaults
let defaults = UserDefaults()

// Blank HTML variable to hold our respones
var html = ""

// Number of Leagues
let numberOfLeagues = leagues.count - 1


// Create our Dispatch Groups for Queue Handling of schedule requests
let lookupScheduleQueue = DispatchGroup()
let lookupLeisureQueue = DispatchGroup()
let lookupBronzeQueue = DispatchGroup()
let lookupSilvereQueue = DispatchGroup()
let lookupGoldQueue = DispatchGroup()
let lookupDiamondQueue = DispatchGroup()


// Setup our storage
var allGames = games()
var myGames = games()
var tempArray = [String]()
var leagueGames = schedule()
var playerGames = schedule()
var myTeam = "Gold"
var skater = profile()

// League Data begins here
var leisure = schedule()
var leisureHTML = ""
var bronze = schedule()
var bronzeHTML = ""
var silver = schedule()
var silverHTML = ""
var gold = schedule()
var goldHTML = ""
var platinum = schedule()
var platinumHTML = ""
var diamond = schedule()
var diamondHTML = ""



class scheduleController: UIViewController {
    @IBOutlet weak var playerLeagueLabel: UILabel!
    
    @IBOutlet weak var giantLabel: UILabel!
    
    
    override func viewDidLoad() {
        print("View did load")
        super.viewDidLoad()
        //print("\(player.shared.league)")
        if let savedLeague1 = defaults.string(forKey: "savedLeague1") {
            player.shared.teamData[0].league = savedLeague1
        }
        if let savedTeam1 = defaults.string(forKey: "savedTeam1") {
            player.shared.teamData[0].team = savedTeam1
        }
        for x in 0..<numberOfLeagues {
            Alamofire.request(leagueScheduleURLs[x], method: .get)
                .validate(statusCode: 200..<300)
                .responseString { response in
                    if (response.result.error == nil) {
                        if x == 0 {
                            //print("Formatting the Leisure schedule...")
                            self.formatData(theData: response.value!, theLeague: leisure, debugLeague: "Leisure")
                            
                        }
                        else if x == 1 {
//                            print("Formatting the Bronze schedule...")
                            self.formatData(theData: response.value!, theLeague: bronze, debugLeague: "Bronze")
                        }
                        else if x == 2 {
//                            print("Formatting the Silver Schedule")
                            self.formatData(theData: response.value!, theLeague: silver, debugLeague: "Silver")
                            
                        }
                        else if x == 3 {
//                            print("Formatting the Gold Schedule")
                            self.formatData(theData: response.value!, theLeague: gold, debugLeague: "Gold")
                        }
                        else if x == 4 {
//                            print("Formatting the Platinum Schedule")
                            self.formatData(theData: response.value!, theLeague: platinum, debugLeague: "Platinum")
                        }
                        else if x == 5 {
//                            print("Formatting the Diamond Schedule")
                            self.formatData(theData: response.value!, theLeague: diamond, debugLeague: "Diamond")
                        }
                        else { print("Not sure why we are here ...") }
                    }
                    else {
                        debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                    }
            }
    }
        

        //lookupSchdules(leagueURL: leagueScheduleURLs)
        
        lookupScheduleQueue.enter()
        Alamofire.request(SILVER_URL, method: .get)
            .validate(statusCode: 200..<300)
            .responseString { response in
                if (response.result.error == nil) {
                    //debugPrint("HTTP Response Body: \(String(describing: response.result))")
                    //print(response.result)
                    html = response.value!
                    lookupScheduleQueue.leave()
                }
                else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                    lookupScheduleQueue.leave()
                }
        }
        // Outside Alamofire
        lookupScheduleQueue.notify(queue: .main, execute: {
        //print("Here is the html body: \(html)")
            //print("======== Here is the Leisure Data ===========" )
            //print("\(leisureHTML)" )
//            print("======== Here is the Bronze Data ===========" )
//            print("\(bronzeHTML)" )
//            print("======== Here is the Silver Data ===========" )
//            print("\(silverHTML)" )
//            print("======== Here is the Gold Data ===========" )
//            print("\(goldHTML)" )
//            print("======== Here is the Platinum Data ===========" )
//            print("\(platinumHTML)" )
//            print("======== Here is the Diamond Data ===========" )
//            print("\(diamondHTML)" )
            
        self.processData(htmlDATA: html)
        } )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View did appear")
        //print("\(player.shared.league)")
        if let savedLeague1 = defaults.string(forKey: "savedLeague1") {
            player.shared.teamData[0].league = savedLeague1
        }
        if let savedTeam1 = defaults.string(forKey: "savedTeam1") {
            player.shared.teamData[0].team = savedTeam1
        }
        print(player.shared.teamData)
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
                theLeague.gameData[x].gameTime = theLeague.gameData[x].gameTime.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameRink = theLeague.gameData[x].gameRink.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameDayOfWeek = theLeague.gameData[x].gameDayOfWeek.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameHomeTeam = theLeague.gameData[x].gameHomeTeam.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameAwayTeam = theLeague.gameData[x].gameAwayTeam.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameLeague = theLeague.gameData[x].gameLeague.replacingOccurrences(of: "<td>", with: "")
                theLeague.gameData[x].gameDate = theLeague.gameData[x].gameDate.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameTime = theLeague.gameData[x].gameTime.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameRink = theLeague.gameData[x].gameRink.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameDayOfWeek = theLeague.gameData[x].gameDayOfWeek.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameHomeTeam = theLeague.gameData[x].gameHomeTeam.replacingOccurrences(of: "</td>\n", with: "")
                theLeague.gameData[x].gameAwayTeam = theLeague.gameData[x].gameAwayTeam.replacingOccurrences(of: "</td>", with: "")
                theLeague.gameData[x].gameLeague = theLeague.gameData[x].gameLeague.replacingOccurrences(of: "</td>\n", with: "")
            }
            //print("Here is the modified Array for \(debugLeague)...")
            //print(theLeague.gameData)
            //print("================================================================")
            var lCounter = 0
            var bCounter = 0
            var sCounter = 0
            var gCounter = 0
            var pCounter = 0
            var dCounter = 0
            for x in 0..<theLeague.gameData.count
            {
            switch theLeague.gameData[x].gameLeague {
            case "Leisure":
                //for x in 0..<theLeague.gameData.count {
                    //print(lCounter)
                    lCounter += 1
                    leisureTeams.insert(theLeague.gameData[x].gameHomeTeam)
                    leisureTeams.insert(theLeague.gameData[x].gameAwayTeam)
                    if lCounter == theLeague.gameData.count {
                        leisureTeams = cleanUpSchedule(theLeagueTeams: leisureTeams, debugLeague: "Leisure")
                    }
                //}
//                leisureTeams = cleanUpSchedule(theLeagueTeams: leisureTeams, debugLeague: "Leisure")
                //preparePlayerTeams()
//                print("Total number of teams in Leisure: \(leisureTeams.count)")
//                print("Here are the teams in Leisure: \(leisureTeams)")
                
            case "Bronze":
                //for x in 0..<theLeague.gameData.count {
                    bCounter += 1
                    bronzeTeams.insert(theLeague.gameData[x].gameHomeTeam)
                    bronzeTeams.insert(theLeague.gameData[x].gameAwayTeam)
                //}
                    if bCounter == theLeague.gameData.count {
                    bronzeTeams = cleanUpSchedule(theLeagueTeams: bronzeTeams, debugLeague: "Bronze")
                }
                //preparePlayerTeams()
//                print("Total number of teams in Bronze: \(bronzeTeams.count)")
//                print("Here are the teams in Bronze: \(bronzeTeams)")
                
            case "Silver":
                //for x in 0..<theLeague.gameData.count {
                    sCounter += 1
                    silverTeams.insert(theLeague.gameData[x].gameHomeTeam)
                    silverTeams.insert(theLeague.gameData[x].gameAwayTeam)
               // }
                    if sCounter == theLeague.gameData.count {
                    silverTeams = cleanUpSchedule(theLeagueTeams: silverTeams, debugLeague: "Silver")
                }
                //preparePlayerTeams()
            
            case "Gold":
               // for x in 0..<theLeague.gameData.count {
                gCounter += 1
                goldTeams.insert(theLeague.gameData[x].gameHomeTeam)
                    goldTeams.insert(theLeague.gameData[x].gameAwayTeam)
                //}
                if gCounter == theLeague.gameData.count {
                    goldTeams = cleanUpSchedule(theLeagueTeams: goldTeams, debugLeague: "Gold")
                }
                //preparePlayerTeams()
                
            case "Platinum":
               // for x in 0..<theLeague.gameData.count {
                pCounter += 1
                platinumTeams.insert(theLeague.gameData[x].gameHomeTeam)
                    platinumTeams.insert(theLeague.gameData[x].gameAwayTeam)
                //}
                if pCounter == theLeague.gameData.count {
                platinumTeams = cleanUpSchedule(theLeagueTeams: platinumTeams, debugLeague: "Platinum")
                   
                }
                //preparePlayerTeams()
                
            case "Diamond":
                
                //for x in 0..<theLeague.gameData.count {
                dCounter += 1
                diamondTeams.insert(theLeague.gameData[x].gameHomeTeam)
                    diamondTeams.insert(theLeague.gameData[x].gameAwayTeam)
                if dCounter == theLeague.gameData.count {
                    diamondTeams = cleanUpSchedule(theLeagueTeams: diamondTeams, debugLeague: "Diamond")
                    let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.preparePlayerTeams()
                    }
                }
                //preparePlayerTeams()

            default:
                break
            }
            }
        } catch let error {
            print(error)
        }
    }
    
    func cleanUpSchedule(theLeagueTeams: Set<String>, debugLeague: String) -> Set<String> {
        print("Cleaning up schedule for \(debugLeague)")
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
                playerGames.gameData.append(leagueSchedule.gameData[x])
                 print("On \(leagueSchedule.gameData[x].gameDate) at \(leagueSchedule.gameData[x].gameTime) on the \(leagueSchedule.gameData[x].gameRink) rink \(leagueSchedule.gameData[x].gameHomeTeam) is playing against \(leagueSchedule.gameData[x].gameAwayTeam)")
            }
            else if leagueSchedule.gameData[x].gameHomeTeam.contains(PLAYOFFString) || leagueSchedule.gameData[x].gameHomeTeam.contains(SEMI_FINALString) || leagueSchedule.gameData[x].gameHomeTeam.contains(FINALString) {
               playerGames.gameData.append(leagueSchedule.gameData[x])
            }
        }
        print("Total number of games found for the player: \(playerGames.gameData.count)")
        
        var allGamesLabel = ""
        
        for x in 0..<playerGames.gameData.count {
        allGamesLabel = allGamesLabel + playerGames.gameData[x].gameLeague + " " + playerGames.gameData[x].gameDayOfWeek + " " + playerGames.gameData[x].gameDate + " " + playerGames.gameData[x].gameTime + " " + playerGames.gameData[x].gameRink + " " + playerGames.gameData[x].gameHomeTeam + " " + playerGames.gameData[x].gameAwayTeam + "\n"
        }
        
        giantLabel.text = allGamesLabel
    
    }
    
    func processData(htmlDATA: String)
    {
        //print("Now to process the data ...")
        do {
            // if encoding is omitted, it defaults to NSUTF8StringEncoding
            let doc = try HTMLDocument(string: htmlDATA, encoding: String.Encoding.utf8)
            for td in doc.css("td") {
                let temp = String(describing: td)
               tempArray.append(temp)
            }
            let gamesOnline = tempArray.count / 7
            //print(tempArray.count / 7 )
            
            for x in 0..<gamesOnline {
                
                //print("Game Date: \(tempArray[(7*x)])")
                allGames.gameDate.append(tempArray[(7*x)])
                //print("Game DOW: \(tempArray[(7*x) + 1])")
                allGames.dayOfWeek.append(tempArray[(7*x)+1])
                //print("Game rink: \(tempArray[(7*x) + 2])")
                allGames.rink.append(tempArray[(7*x)+2])
                //print("Game Time: \(tempArray[(7*x) + 3])")
                allGames.gameTime.append(tempArray[(7*x)+3])
                //print("Game League: \(tempArray[(7*x) + 4])")
                allGames.gameLeague.append(tempArray[(7*x)+4])
                //print("Game home: \(tempArray[(7*x) + 5])")
                allGames.homeTeam.append(tempArray[(7*x)+5])
                //print("Game Away: \(tempArray[(7*x) + 6])")
                allGames.awayTeam.append(tempArray[(7*x)+6])
                
                // New code
                leagueGames.gameData.append((gameDate: tempArray[(7*x)], gameDayOfWeek: tempArray[(7*x)+1], gameRink: tempArray[(7*x)+2], gameTime: tempArray[(7*x)+3], gameLeague: tempArray[(7*x)+4], gameHomeTeam: tempArray[(7*x)+5], gameAwayTeam: tempArray[(7*x)+6]))
            }
            
            //print(myGames.gameDate.count)
            //print(gamesOnline)
            //print("HOME TEAM FORMAT >>>>>\(myGames.homeTeam[0])<<<<<<<")
//            var counter = 0
            //print("Number of items in the leagueGames.GameData array: \(leagueGames.gameData.count)")
            //print(myGames.homeTeam[0])
//            for x in 0..<gamesOnline {
//                if allGames.homeTeam[x] == "<td>Gold</td>\n"  {
//                    counter += 1
//                    //print("=====Home Game=====")
//                    myGames.dayOfWeek.append(allGames.dayOfWeek[x])
//                    myGames.gameDate.append(allGames.gameDate[x])
//                    myGames.gameTime.append(allGames.gameTime[x])
//                    myGames.rink.append(allGames.rink[x])
//                    myGames.homeTeam.append(allGames.homeTeam[x])
//                    myGames.awayTeam.append(allGames.awayTeam[x])
//                    //print("Game Date: \(myGames.dayOfWeek[x]), \(myGames.gameDate[x]) at \(myGames.gameTime[x]) on \(myGames.rink[x]) rink is \(myGames.homeTeam[x]) v. \(myGames.awayTeam[x])")
//                }
//                else if allGames.awayTeam[x] == "<td>Gold</td>" {
//                    counter += 1
//                    //print("======Away Game=====")
//                    myGames.dayOfWeek.append(allGames.dayOfWeek[x])
//                    myGames.gameDate.append(allGames.gameDate[x])
//                    myGames.gameTime.append(allGames.gameTime[x])
//                    myGames.rink.append(allGames.rink[x])
//                    myGames.homeTeam.append(allGames.homeTeam[x])
//                    myGames.awayTeam.append(allGames.awayTeam[x])
//                    //print("Game Date: \(myGames.dayOfWeek[x]), \(myGames.gameDate[x]) at \(myGames.gameTime[x]) on \(myGames.rink[x]) rink is \(myGames.homeTeam[x]) v. \(myGames.awayTeam[x])")
//                }
//            }
//            print("Total found games --> \(myGames.dayOfWeek.count)")
            //print("Looking for my games with new code ....")
//            for x in 0..<leagueGames.gameData.count {
//                if leagueGames.gameData[x].gameLeague.contains("Silver") {
//                    if leagueGames.gameData[x].gameHomeTeam.contains(myTeam) || leagueGames.gameData[x].gameAwayTeam.contains(myTeam) {
//                        //print("Gold is playing in this game")
//                        //print("On \(leagueGames.gameData[x].gameDate) at \(leagueGames.gameData[x].gameTime) on the \(leagueGames.gameData[x].gameRink) rink \(leagueGames.gameData[x].gameHomeTeam) is playing against \(leagueGames.gameData[x].gameAwayTeam)")
//                        playerGames.gameData.append(leagueGames.gameData[x])
//                    }
//                    else if
//                        leagueGames.gameData[x].gameHomeTeam.contains(PLAYOFFString) || leagueGames.gameData[x].gameHomeTeam.contains(SEMI_FINALString) || leagueGames.gameData[x].gameHomeTeam.contains(FINALString) {
//                        playerGames.gameData.append(leagueGames.gameData[x])
//                    }
//                }
//            }
//            var allGamesLabel = ""
            //print("Here is the player array:")
            //print(playerGames.gameData)
            //print("Formatting data now ...")
//            for x in 0..<playerGames.gameData.count {
//                playerGames.gameData[x].gameDate = playerGames.gameData[x].gameDate.replacingOccurrences(of: "<td>", with: "")
//                playerGames.gameData[x].gameTime = playerGames.gameData[x].gameTime.replacingOccurrences(of: "<td>", with: "")
//                playerGames.gameData[x].gameRink = playerGames.gameData[x].gameRink.replacingOccurrences(of: "<td>", with: "")
//                playerGames.gameData[x].gameDayOfWeek = playerGames.gameData[x].gameDayOfWeek.replacingOccurrences(of: "<td>", with: "")
//                playerGames.gameData[x].gameHomeTeam = playerGames.gameData[x].gameHomeTeam.replacingOccurrences(of: "<td>", with: "")
//                playerGames.gameData[x].gameAwayTeam = playerGames.gameData[x].gameAwayTeam.replacingOccurrences(of: "<td>", with: "")
//                playerGames.gameData[x].gameLeague = playerGames.gameData[x].gameLeague.replacingOccurrences(of: "<td>", with: "")
//
//
//                playerGames.gameData[x].gameDate = playerGames.gameData[x].gameDate.replacingOccurrences(of: "</td>\n", with: "")
//                playerGames.gameData[x].gameTime = playerGames.gameData[x].gameTime.replacingOccurrences(of: "</td>\n", with: "")
//                playerGames.gameData[x].gameRink = playerGames.gameData[x].gameRink.replacingOccurrences(of: "</td>\n", with: "")
//                playerGames.gameData[x].gameDayOfWeek = playerGames.gameData[x].gameDayOfWeek.replacingOccurrences(of: "</td>\n", with: "")
//                playerGames.gameData[x].gameHomeTeam = playerGames.gameData[x].gameHomeTeam.replacingOccurrences(of: "</td>\n", with: "")
//                playerGames.gameData[x].gameAwayTeam = playerGames.gameData[x].gameAwayTeam.replacingOccurrences(of: "</td>", with: "")
//                playerGames.gameData[x].gameLeague = playerGames.gameData[x].gameLeague.replacingOccurrences(of: "</td>\n", with: "")
//
//            }
            //print("Here is the modified Array  ...")
            //print(playerGames.gameData)
            
            
            //print("Possible Number of Games: \(playerGames.gameData.count)")
//            for x in 0..<playerGames.gameData.count {
//                //allGamesLabel = allGamesLabel + playerGames.gameData[x].gameLeague + " " + playerGames.gameData[x].gameDayOfWeek + " " + playerGames.gameData[x].gameDate + " " + playerGames.gameData[x].gameTime + " " + playerGames.gameData[x].gameRink + " " + playerGames.gameData[x].gameHomeTeam + " " + playerGames.gameData[x].gameAwayTeam + "\n"
//            }
            //print(allGamesLabel)
            //giantLabel.text = allGamesLabel
//            gameDayOfWeekLabel.text = allGameDayLabel
//            gameTimeLabel.text = allGameTimeLabel
//            gameRinkLabel.text = allRinkLabel
//            gameHomeTeamLabel.text = allHomeTeamLabel
//            gameAwayTeamLabel.text = allAwayTeamLabel
            
            // CSS queries
            //if let elementById = doc.firstChild(css: "#id") {
                //print(elementById.stringValue)
            //}
            //for link in doc.css("a, link") {
                //print(link.rawXML)
                //print(link["href"])
           // }
            
            // XPath queries
            //if let firstAnchor = doc.firstChild(xpath: "//body/a") {
                //print(firstAnchor["href"])
           // }
            //for script in doc.xpath("//head/script") {
                //print(script["src"])
            //}
            
            // Evaluate XPath functions
            //if let result = doc.eval(xpath: "count(/*/a)") {
               // print("anchor count : \(result.doubleValue)")
           // }
            
            // Convenient HTML methods
            //print(doc.title) // gets <title>'s innerHTML in <head>
            //print(doc.head)  // gets <head> element
            //print(doc.body)  // gets <body> element
            

            
        } catch let error {
            print(error)
        }
        
        
        // End Processing Data
        
    }
    
//    func lookupSchdules(leagueURL: Array<String>) {
//        //print("Entered lookup Schedule function...")
//        for x in 0..<leagueURL.count {
//            print("League URL: \(leagueURL[x])")
//        }
//
//    }
    
}

