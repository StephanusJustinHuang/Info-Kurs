//
//  DataModel.swift
//  Info Kurs
//
//  Created by Justin Huang on 5/23/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import Foundation

protocol dataRetrievedProtocol {
    
    func dataRetrieved(_ data:[HargaKurs])
}

class DataModel {
    
    var delegate:dataRetrievedProtocol?
    
    func getData() {
        
        //Get the API reference
        let stringUrl = "https://www.adisurya.net/kurs-bca/get"
        let url = URL(string: stringUrl)
        guard url != nil else {
            print("Could not create url object")
            return
        }
        
        //Create the session and dataTask to connect with the API
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                    let dataSevice = try decoder.decode(DataService.self, from: data!)
                    var arrayOfData = [HargaKurs]()
                    
                    let AUD = dataSevice.Data.AUD
                    let CAD = dataSevice.Data.CAD
                    let CHF = dataSevice.Data.CHF
                    let CNH = dataSevice.Data.CNH
                    let DKK = dataSevice.Data.DKK
                    let EUR = dataSevice.Data.EUR
                    let GBP = dataSevice.Data.GBP
                    let HKD = dataSevice.Data.HKD
                    let JPY = dataSevice.Data.JPY
                    let NZD = dataSevice.Data.NZD
                    let SAR = dataSevice.Data.SAR
                    let SEK = dataSevice.Data.SEK
                    let SGD = dataSevice.Data.SGD
                    let THB = dataSevice.Data.THB
                    let USD = dataSevice.Data.USD
                    
                    
                    
                    guard AUD != nil && CAD != nil && CHF != nil && CNH != nil && DKK != nil && EUR != nil && GBP != nil && HKD != nil && JPY != nil && NZD != nil && SAR != nil && SEK != nil && SGD != nil && THB != nil && USD != nil else {
                        print("one or more of the currency is not found")
                        return
                    }
                    
                    arrayOfData = [AUD!,CAD!,CHF!,CNH!,DKK!,EUR!,GBP!,HKD!,JPY!,NZD!,SAR!,SEK!,SGD!,THB!,USD!]
                    
                    DispatchQueue.main.async {
                        self.delegate?.dataRetrieved(arrayOfData)
                    }
                }
                catch {
                    print("error parsing JSON")
                }
            }
        }
        dataTask.resume()
    }
    
}
