//
//  ViewController.swift
//  Stonks
//
//  Created by Nikita Vesna on 28.08.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var infoManager = APIStockManager(apiKey: "pk_4eae54de1f214380a20f3d0825b1dfb2")
    var companies = [
        "Apple": "AAPL",
        "Microsoft": "MSFT",
        "Google": "GOOG",
        "Amazon": "AMZN",
        "Facebook": "FB"
    ]
    
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var symbolLbl: UITextField!
    @IBOutlet weak var priceLbl: UITextField!
    @IBOutlet weak var priceChangeLbl: UITextField!
    @IBOutlet weak var networkActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var logoLoadingActivityController: UIActivityIndicatorView!
    
    enum Indicators {
        case network
        case logo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.dataSource = self
        picker.delegate = self
        
        onStartup()
        
        
        
    }
    
    
    func onStartup() {
        networkActivityIndicator.hidesWhenStopped = true
        logoLoadingActivityController.hidesWhenStopped = true
        
        removeOnLoad()
        
        let selectedRow = picker.selectedRow(inComponent: 0)
        let selectedSymbol = Array(companies.values)[selectedRow]
        
        requestStockInfo(for: selectedSymbol)
    }
    
    func removeOnLoad() {
        let removeTextOnLoad = [nameLbl, symbolLbl, priceLbl, priceChangeLbl]
        for label in removeTextOnLoad {
            label?.text = "-"
            label?.textColor = .black
        }
        
        imageView.image = nil
    }
    
    func toogleActivityIndicator(indicator activity: Indicators, activeNow on: Bool) {
        
        switch activity {
        case .network:
            on ? networkActivityIndicator.startAnimating() : networkActivityIndicator.stopAnimating()
        case .logo:
            on ? logoLoadingActivityController.startAnimating() : logoLoadingActivityController.stopAnimating()
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedSymbol = Array(companies.values)[row]
        requestStockInfo(for: selectedSymbol)
    }
    
    func requestStockInfo(for symbol: String) {
        
        
        toogleActivityIndicator(indicator: .network, activeNow: true)
        toogleActivityIndicator(indicator: .logo, activeNow: true)
        removeOnLoad()
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            self.loadLogo(symbol: symbol)
            
            self.infoManager.fetchStockInfoFor(symbol: symbol) { (result) in
                
                self.toogleActivityIndicator(indicator: .network, activeNow: false)
                
                switch result {
                case .Success(let stockInfo):
                    self.updateUIWith(info: stockInfo)
                case .Failure(let error as NSError):
                    
                    let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func loadLogo(symbol: String) {
        
        let imageData = infoManager.fetchLogoFor(symbol: symbol)
        updateLogo(imageData: imageData)
    }
    
    func updateLogo(imageData: Data) {
        self.toogleActivityIndicator(indicator: .logo, activeNow: false)
        if let image = UIImage(data: imageData) {
            imageView.image = image
        }
    }
    
    func updateUIWith(info stock: Stock) {
        nameLbl.text = stock.name
        symbolLbl.text = stock.symbol
        priceLbl.text = String(stock.price)
        priceChangeLbl.text = String(stock.change)
        
        switch stock.change {
        case ..<0:
            priceChangeLbl.textColor = .red
        case 0:
            priceChangeLbl.textColor = .black
        default:
            priceChangeLbl.textColor = .green
        }
    }
    
}


// MARK: - PickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        companies.keys.count
    }
    
}


// MARK: - PickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(companies.keys)[row]
    }
}
