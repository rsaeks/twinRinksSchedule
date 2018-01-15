//Constants begin here
//
//Leagues

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
let PLAYOFFString = "PLAYOFF"
let SEMI_FINALString = "SEMI FINAL"
let FINALString = "FINAL"

//Items to remove from schedule
//let cleanup = ["", "PLAYOFF", "SEMI FINAL", "FINAL","HOCKEY APPRECIATION DAY", "Hockey Appreciation Day", "Hockey appreciation Day", "Hockey appreciation day", "FREE RAT HOCKEY", "Free Rat Hockey", "Last Day for $46 Discount","Last day for $46 discount","Last Day for $46 discount","Early Captains meet for the draft","early captains meet for the draft","Early captains meet for the draft","Early teams meet for the draft","All Captains meet for the draft","all captains meet for the draft","All captains meet for the draft","All teams meet for the draft", "last day for $ discount", "free rat hockey", "hockey appreciation day", "final", "playoff", "semi final" ]

let cleanup = ["", "lastdayfor$discount", "freerathockey", "hockeyappreciationday", "final", "playoff", "semifinal", "allcaptainsmeetforthedraft", "earlycaptainsmeetforthedraft", "allteamsmeetforthedraft", "earlyteamsmeetforthedraft" ]
