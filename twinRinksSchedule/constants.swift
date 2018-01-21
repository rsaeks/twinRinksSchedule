//Constants begin here
//
//Leagues
import UIKit

let leagues = ["Select league","Leisure","Bronze","Silver","Gold","Platinum","Diamond"]
let teams = ["Select team"," Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Black", "White", "Grey"]
let teamsInit = [ "Select League" ]
let cleanupTeamItems = [ "(", ")", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "/", "\\", "win", " " ]

//League schedule URLs
let LEISURE_URL = "http://twinrinks.com/recl/leisure%20schedule.php"
let BRONZE_URL = "http://twinrinks.com/recb/bronze%20schedule.php"
let SILVER_URL = "http://twinrinks.com/recs/silver%20schedule.php"
let GOLD_URL = "http://twinrinks.com/recg/gold%20schedule.php"
let PLATINUM_URL = "http://twinrinks.com/recp/platinum%20schedule.php"
let DIAMOND_URL = "http://twinrinks.com/recd/diamond%20schedule.php"
let leagueScheduleURLs = [LEISURE_URL, BRONZE_URL, SILVER_URL, GOLD_URL, PLATINUM_URL, DIAMOND_URL]

// Data constants
let PLAYOFFString = "Playoff"
let SEMI_FINALString = "Semi Final"
let FINALString = "Final"

//Items to remove from schedule
let cleanup = ["", "PLAYOFF", "SEMI FINAL", "FINAL","HOCKEY APPRECIATION DAY", "Hockey Appreciation Day", "Hockey appreciation Day", "Hockey appreciation day", "FREE RAT HOCKEY", "Free Rat Hockey", "Last Day for $46 Discount","Last day for $46 discount","Last Day for $46 discount","Early Captains meet for the draft","early captains meet for the draft","Early captains meet for the draft","Early teams meet for the draft","All Captains meet for the draft","all captains meet for the draft","All captains meet for the draft","All teams meet for the draft", "last day for $ discount", "free rat hockey", "hockey appreciation day", "final", "playoff", "semi final", "Final", "Playoff" ]

// Setup Team Colors
let Black = UIColor.black
let Blue = UIColor.init(red: 0, green: 135, blue: 197, alpha: 1)
let Brass = UIColor.init(red: 71, green: 65, blue: 26, alpha: 1)
let Brown = UIColor.brown
let Copper = UIColor.init(red: 196, green: 126, blue: 90, alpha: 1)
let Gold = UIColor.init(red: 255, green: 216, blue: 88, alpha: 1)
let Grey = UIColor.gray
let Kelly = UIColor.green
let Lime = UIColor.init(red: 186, green: 223, blue: 48, alpha: 1)
let Orange = UIColor.orange
let Purple = UIColor.purple
let Red = UIColor.red
let Royal = UIColor.init(red: 0, green: 35, blue: 156, alpha: 1)
let Tan = UIColor.init(red: 209, green: 178, blue: 144, alpha: 1)
let Teal = UIColor.init(red: 0, green: 126, blue: 126, alpha: 1)
let White = UIColor.white
let Yellow = UIColor.yellow
