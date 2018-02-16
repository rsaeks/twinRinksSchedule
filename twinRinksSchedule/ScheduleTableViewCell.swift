//
//  ScheduleTableViewCell.swift
//  twinRinksSchedule
//
//  Created by Randy Saeks on 1/14/18.
//  Copyright © 2018 Randy Saeks. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var TableViewCellLeagueImage: UIImageView!
    @IBOutlet weak var TableViewCellHomeOrAwayImage: UIImageView!
    @IBOutlet weak var TableViewCellDate: UILabel!
    @IBOutlet weak var TableViewCellDayOfWeek: UILabel!
    @IBOutlet weak var TableViewCellTime: UILabel!
    @IBOutlet weak var TableViewCellAgainst: UILabel!
    
    func updateViews(leagueImage: String, homeTeam: String, date: String, dayOfWeek: String, time: String, awayTeam: String, rink: String) {
        
        TableViewCellDate.text = date
        TableViewCellDayOfWeek.text = dayOfWeek
        TableViewCellTime.text = time
        TableViewCellLeagueImage.image = UIImage(named: "\(leagueImage).png")
        
//        print("Player Team: \(player.shared.teamData[0].team)")
//        print("Home Team: \(homeTeam)")
//        print("Away Team: \(awayTeam)")
        
        if homeTeam == player.shared.teamData[0].team {
            TableViewCellHomeOrAwayImage.image = #imageLiteral(resourceName: "home")
            TableViewCellAgainst.text = awayTeam
        }
        else if awayTeam == player.shared.teamData[0].team {
            TableViewCellHomeOrAwayImage.image = #imageLiteral(resourceName: "away")
            TableViewCellAgainst.text = homeTeam
        }
        else { TableViewCellAgainst.text = homeTeam }
    }

}
