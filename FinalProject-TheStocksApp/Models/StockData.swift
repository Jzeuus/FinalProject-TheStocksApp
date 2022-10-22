//
//  StockData.swift
//  FinalProject-TheStocksApp
//
//  Created by Jesus Alvarado on 5/24/22.
//

import Foundation

class StockData{

    var open: Double?
    var close: Double?
    var volume: Int64?
    
// initializers
    init(
         open:Double?, close:Double?, volume:Int64?){
        self.open = open
        self.close = close
        self.volume = volume
        
    }
    
    
}
