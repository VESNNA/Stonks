//
//  APIStockManager.swift
//  Stonks
//
//  Created by Nikita Vesna on 30.08.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import Foundation


enum ForecastType: FinalURLPoint  {
    
    case Default(apiKey: String, symbol: String)
    
    var baseURL: URL {
        return URL(string: "https://cloud.iexapis.com")!
    }
    
    var path: String {
        switch self {
        case .Default(let apiKey, let symbol):
            return "/stable/stock/\(symbol)/quote?token=\(apiKey)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
}

final class APIStockManager: APIManager {
    
    let sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    } ()
    
    let apiKey : String
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchStockInfoFor(symbol: String, completionHandler: @escaping (APIResult<Stock>) -> Void) {
        let request = ForecastType.Default(apiKey: self.apiKey, symbol: symbol).request
        
        fetch(request: request, parse: { (json) -> Stock? in
            let dictionary:[String: AnyObject] = json
            return Stock(JSON: dictionary)
            
        }, completionHandler: completionHandler)
    }
    
}
