//
//  SecondViewController.swift
//  twinRinksSchedule
//
//  Created by Randy Saeks on 11/13/17.
//  Copyright © 2017 Randy Saeks. All rights reserved.
//

import UIKit
import WebKit
import KeychainSwift

var loginUsername = ""
var loginPassword = ""

class checkinController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let savedUsername = defaults.string(forKey: "savedUsername") {
            loginUsername = savedUsername
        }
        
        if let savedPassword = keychain.get("savedPassword") {
            loginPassword = savedPassword
        }
        
        let url = URL(string: "http://twinrinks.com/adulthockey/subs/subs_entry.php?subs_data1=\(loginUsername)&subs_data2=\(loginPassword)")!
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: url))

    }
}
