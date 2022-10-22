//
//  StockJSON.swift
//  FinalProject-TheStocksApp
//
//  Created by Jesus Alvarado on 5/24/22.
//

import Foundation


struct StockInnerJSON: Decodable {

    enum CodingKeys: String, CodingKey {
        case openPrice = "o"
        case closePrice = "c"
        case volume = "v"
        
    }
    
    let openPrice: Double?
    let closePrice: Double?
    let volume: Int64?
  
   
}

struct StockOuterJSON: Decodable{
    
    let results: [StockInnerJSON]?
    let ticker: String?
}
