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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
