//
//  DataCell.swift
//  Info Kurs
//
//  Created by Justin Huang on 5/24/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {
    
    @IBOutlet weak var tipeKursText: UILabel!
    
    @IBOutlet weak var jualText: UILabel!
    
    @IBOutlet weak var beliText: UILabel!
    
    @IBOutlet weak var kursImageView: UIImageView!
    
    var dataToDisplay:HargaKurs?
    
    var tipeKursToDisplay:String?
    
    var counter = 1
    
    func displayData(_ data:HargaKurs, mataUang:String) {
        
        DispatchQueue.main.async {
            self.kursImageView.image = UIImage(named: mataUang)
            //self.kursImageView.setNeedsLayout()
            self.kursImageView.alpha = 1
        }
        
        
        //custom the images
        //clean up the cell before displaying the next. so there will be no weird behaviour
        //kursImageView.image = nil
        kursImageView.alpha = 0
        
        tipeKursText.text = ""
        tipeKursText.alpha = 0
        jualText.text = ""
        jualText.alpha = 0
        beliText.text = ""
        beliText.alpha = 0
        
        dataToDisplay = data
        tipeKursToDisplay = mataUang
        
        tipeKursText.text = tipeKursToDisplay
        
        
        beliText.text = "Buy  -  Rp." + dataToDisplay!.Beli!
        jualText.text = "Sell -  Rp." + dataToDisplay!.Jual!
        counter += 1
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.tipeKursText.alpha = 1
            self.jualText.alpha = 1
            self.beliText.alpha = 1
        }, completion: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
