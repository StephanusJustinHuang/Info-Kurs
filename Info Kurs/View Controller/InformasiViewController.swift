//
//  InformasiViewController.swift
//  Info Kurs
//
//  Created by Justin Huang on 5/24/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import UIKit

class InformasiViewController: UIViewController, dataRetrievedProtocol  {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var background: UIImageView!
    
    var model = DataModel()
    var datas = [HargaKurs]()
    var currency = ["AUD","CAD","CHF","CNH","DKK","EUR","GBP","HKD","JPY","NZD","SAR","SEK","SGD","THB","USD"]

    override func viewDidLoad() {
        super.viewDidLoad()
        background.alpha = 0.35
        
        //Add pull to refresh
        addRefreshControl()
        
        print("executed")
        
    }
    
    func addRefreshControl(){
        //Create refresh control
        let refresh = UIRefreshControl()
        
        //set target
        refresh.addTarget(self, action: #selector(refreshFeed(refreshControl:)), for: .valueChanged)
        
        //add to tableview
        self.tableView.addSubview(refresh)
    }
    
    @objc func refreshFeed(refreshControl: UIRefreshControl) {
        //call to retrieve the data and reload the table view
        model.getData()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            //stop spinner
            refreshControl.endRefreshing()
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        
        model.delegate = self
        model.getData()
        spinner.startAnimating()
    }
}

extension InformasiViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataCell
        
        //get the article that the tableVIEW is asking about
        let data = datas[indexPath.row]
        let mataUang = currency[indexPath.row]
        
        //TODO: Customize it
        cell.displayData(data, mataUang: mataUang)
        
        //return the cell
        spinner.stopAnimating()
        spinner.alpha = 0
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ConverterViewController") as! ConverterViewController
        
        vc.image = UIImage(named: currency[indexPath.row])!
        vc.mataUang = currency[indexPath.row]
        vc.data = datas[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dataRetrieved(_ data: [HargaKurs]) {
        self.datas = data
        print("successfully get data")
        print(data)
        
        //REMEMBER REMEMBER REMEMBER refresh tableview
        tableView.reloadData()
    }
}
