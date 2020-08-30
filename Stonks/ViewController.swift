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

    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var symbolLbl: UITextField!
    @IBOutlet weak var priceLbl: UITextField!
    @IBOutlet weak var priceChangeLbl: UITextField!
    @IBOutlet weak var networkActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var picker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onStartup()
        
        requestStockInfo(for: "AAPL")
        
    }
    
    
    func onStartup() {
        networkActivityIndicator.hidesWhenStopped = true
        networkActivityIndicator.color = .black
        
        let removeTextOnLoad = [nameLbl, symbolLbl, priceLbl, priceChangeLbl]
        for label in removeTextOnLoad {
            label?.text = "-"
        }
    }
    
    func requestStockInfo(for symbol: String) {
        
        
        DispatchQueue.global(qos: .userInitiated).sync {
            networkActivityIndicator.startAnimating()
            
            infoManager.fetchStockInfoFor(symbol: "AAPL") { (result) in
                
                //self.toggleActivityIndicator(active: false)
                
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
            
            networkActivityIndicator.stopAnimating()
            
        }
        
        
    }
    
    func updateUIWith(info stock: Stock) {
        nameLbl.text = stock.name
        symbolLbl.text = stock.symbol
        priceLbl.text = String(stock.price)
        priceChangeLbl.text = String(stock.change)
        
    }

}

