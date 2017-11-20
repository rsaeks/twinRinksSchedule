
import Foundation
import UIKit

var leisureTeams = Set<String>()
var bronzeTeams = Set<String>()
var silverTeams = Set<String>()
var goldTeams = Set<String>()
var platinumTeams = Set<String>()
var diamondTeams = Set<String>()

class player {
    static var shared = player()
    private init () {}
    //var teamData:[(league:String,team: String)] = []
    var teamData = [(league: "Select League", team: "Select team")]
    var league = "Please select your league"
    var team = "Please select your team"
}

class profile {
    static var global = profile()
    init () {}
    var teamData:[(league:String,team: String)] = []
}

class games {
    var gameDate = [String]()
    var dayOfWeek = [String]()
    var rink = [String]()
    var gameTime = [String]()
    var gameLeague = [String]()
    var homeTeam = [String]()
    var awayTeam = [String]()
}

class schedule {
    var gameData:[(gameDate:String,gameDayOfWeek:String,gameRink:String,gameTime:String,gameLeague:String,gameHomeTeam: String,gameAwayTeam: String)] = []
}
