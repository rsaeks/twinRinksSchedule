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

// Rink Colors

let BlueRink = UIColor(red: 84/255, green: 137/255, blue: 234/255, alpha: 0.75)
let RedRink = UIColor(red: 201/255, green: 106/255, blue: 106/255, alpha: 0.75)


// Setup Team Colors
let Black = UIColor.black.cgColor
let Blue = UIColor.init(red: 0/255, green: 135/255, blue: 197/255, alpha: 1.0).cgColor
let Brass = UIColor(red: 188/255, green: 181/255, blue: 49/255, alpha: 1.0).cgColor
let Brown = UIColor(red: 84/255, green: 46/255, blue: 0/255, alpha: 1.0).cgColor
let Copper = UIColor.init(red: 196/255, green: 126/255, blue: 90/255, alpha: 1.0).cgColor
let Gold = UIColor.init(red: 255/255, green: 216/255, blue: 88/255, alpha: 1.0).cgColor
let Grey = UIColor.gray.cgColor
let Kelly = UIColor(red: 0/255, green: 96/255, blue: 25/255, alpha: 1.0).cgColor
let Lime = UIColor.init(red: 186/255, green: 223/255, blue: 48/255, alpha: 1).cgColor
let Orange = UIColor(red: 239/255, green: 131/255, blue: 0/255, alpha: 1.0).cgColor
let Purple = UIColor(red: 108/255, green: 0/255, blue: 191/255, alpha: 1.0).cgColor
let Red = UIColor(red: 206/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
let Royal = UIColor.init(red: 0/255, green: 35/255, blue: 156/255, alpha: 1).cgColor
let Tan = UIColor.init(red: 209/255, green: 178/255, blue: 144/255, alpha: 1).cgColor
let Teal = UIColor.init(red: 0/255, green: 126/255, blue: 126/255, alpha: 1).cgColor
let White = UIColor.white.cgColor
let Yellow = UIColor(red: 255/255, green: 255/255, blue: 112/255, alpha: 1.0).cgColor
