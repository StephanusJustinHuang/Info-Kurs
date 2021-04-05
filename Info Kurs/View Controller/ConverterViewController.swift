//
//  ConverterViewController.swift
//  Info Kurs
//
//  Created by Justin Huang on 5/30/20.
//  Copyright © 2020 Justin Huang. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {

    @IBOutlet weak var countryDetailLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var indoFlagImage: UIImageView!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var jumlahIdrTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var rincianLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var jumlahTypeLabel: UILabel!
    
    var image = UIImage()
    var data = HargaKurs()
    var mataUang = ""
    var rincian:String? = ""
    
    var list = ["Buy","Sell"] //create the drop down list
    var storeTransaction:Double? //Keep the rate of the transaction either 'beli' or 'jual'
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jumlahIdrTextField.placeholder = "Insert amount"
        
        background.alpha = 0.35
        
        indoFlagImage.layer.cornerRadius = 8
        indoFlagImage.layer.borderWidth = 3
        indoFlagImage.layer.borderColor = UIColor.black.cgColor
        
        flagImage.layer.cornerRadius = 8
        flagImage.layer.borderWidth = 3
        flagImage.layer.borderColor = UIColor.black.cgColor
        
        convertButton.layer.cornerRadius = 8
        convertButton.layer.borderWidth = 1
        convertButton.layer.borderColor = UIColor.black.cgColor
        
        countryDetailLabel.text = "IDR - \(mataUang)"
        flagImage.image = image
        
        //Adding done button to the keypad so user can exit when done typing
        addDoneButton()
        
        //to dismiss the keypad when user touch anywhere else (done inserting the amount)
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
        
        let strBeli = String(data.Beli!) //Keep track of the 'beli' rate
        
        // formatting from string into double. Because from the API the rate is in the string format
        let doubleFormatBeli = NumberFormatter().number(from: strBeli)?.doubleValue
        
        //Set the default of the scrolable list into 'Beli'
        storeTransaction = doubleFormatBeli
        rincian = "\(doubleFormatBeli!)"
    }
    
    //when convert button is pressed
    @IBAction func convertButton(_ sender: Any) {
        calculateAndDisplayResult()
    }
    
    //To calculate the currency conversiion base on selected option and input
    func calculateAndDisplayResult() {
        let textBoxDouble = Double(jumlahIdrTextField.text!)
        
        if textBoxDouble == nil {
            print("no money inputed")
            totalAmountLabel.text = ""
            rincianLabel.textColor = UIColor.red
            rincianLabel.text = "Please insert amount."
            
        } else {
            if (jumlahTypeLabel.text == "Amount IDR:"){
                let total = (textBoxDouble! / storeTransaction!)
                let stringTotal = String(format:"%.2f",total)
                
                totalAmountLabel.text = "\(mataUang) \(stringTotal)"
                
                rincianLabel.textColor = UIColor.black
                rincianLabel.text = "Detail:\n1 \(mataUang) = Rp \(rincian! )\nRp \(textBoxDouble!) ÷ Rp \(rincian! ) per 1 \(mataUang)\nTotal =  \(mataUang) \(stringTotal)"
            } else{
                let total = (textBoxDouble! * storeTransaction!)
                let stringTotal = String(format:"%.2f",total)
                               
                totalAmountLabel.text = "Rp. \(stringTotal)"
                               
                rincianLabel.textColor = UIColor.black
                rincianLabel.text = "Detail:\n1 \(mataUang) = Rp. \(rincian!) \n\(mataUang) \(textBoxDouble!) × Rp \(rincian! ) \nTotal =  Rp. \(stringTotal)"
            }
        }
    }
    
    //Done button on the keypad, so user can dismiss the keypad when done typing.
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        jumlahIdrTextField.inputAccessoryView = keyboardToolbar
    }
}

extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //formatting the string of jual and beli into double
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard data.Jual != nil && data.Beli != nil else{
            print("data jual or data beli is nil")
            return
        }
        
        let strJual = String(data.Jual!)
        
        let strBeli = String(data.Beli!)
        
        let doubleFormatJual = NumberFormatter().number(from: strJual)?.doubleValue
        
        let doubleFormatBeli = NumberFormatter().number(from: strBeli)?.doubleValue

        switch row {

        //Selected Beli
        case 0:
            storeTransaction = doubleFormatBeli
            rincian = "\(doubleFormatBeli!)"
            jumlahTypeLabel.text = "Amount IDR:"
            rincianLabel.text = "Detail:"
            totalAmountLabel.text = ""
 
            
        
            //Selected Jual
        case 1:
            storeTransaction = doubleFormatJual
            rincian = "\(doubleFormatJual!)"
            jumlahTypeLabel.text = "Amount \(mataUang):"
            rincianLabel.text = "Detail:"
            totalAmountLabel.text = ""

        default:
            print("weird behaviour on picker view selection");
            return
        }
    }
}
