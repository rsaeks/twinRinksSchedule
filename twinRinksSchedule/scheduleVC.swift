//
//  FirstViewController.swift
//  twinRinksSchedule
//
//  Created by Randy Saeks on 11/13/17.
//  Copyright © 2017 Randy Saeks. All rights reserved.
//

import UIKit

let defaults = UserDefaults()

class scheduleController: UIViewController {
    @IBOutlet weak var playerLeagueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.string(forKey: "savedLeague") == nil {
            print("No league set")
        }
        else {
            //print("User is in league: \(String(describing: defaults.string(forKey: "savedLeague")))")
            player.shared.league = defaults.string(forKey: "savedLeague")!
            //print(selectedLeague)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("\(player.shared.league)")
        self.playerLeagueLabel.text = player.shared.league
        
    }
}

