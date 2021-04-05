//
//  HomeViewController.swift
//  Info Kurs
//
//  Created by Justin Huang on 5/24/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var timer = Timer()

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var waktuLabel: UILabel!
    
    @IBOutlet weak var tanggalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLabels()

        // Do any additional setup after loading the view.
    }
    
    //showing the time and date
    func displayLabels(){
        waktuLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        tanggalLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .full, timeStyle: .none)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
        
    }
    
    //showing the updated time and date live
    @objc func tick() {
        tanggalLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .full, timeStyle: .none)
        waktuLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
    }
}
