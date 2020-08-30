//
//  Model.swift
//  Stonks
//
//  Created by Nikita Vesna on 28.08.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import Foundation

struct Stock {
    var name: String
    var symbol: String
    var price: Double
    var change: Double
}

extension Stock: JSONDecodable {
    init?(JSON: [String: AnyObject]) {
        guard //let json = JSON["main"] as? NSDictionary,
            let companyName = JSON["companyName"] as? String,
            let symbol = JSON["symbol"] as? String,
            let price = JSON["latestPrice"] as? Double,
            let priceChange = JSON["chang"] as? Double
            
        else {
                print("JSON processing error")
                return nil
        }
        
        self.name = companyName
        self.symbol = symbol
        self.price = price
        self.change = priceChange
    }
}
