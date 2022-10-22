//
//  StockModel.swift
//  FinalProject-TheStocksApp
//
//  Created by Jesus Alvarado on 5/24/22.
//

import Foundation

class StockModel {
    public var tickerSymbol: String?
    public var stockDataResults = Array<StockData>()
    
    init(){
        
    }
    // how many rows
    func getCountOfRows()->Int {
        return stockDataResults.count
    }
    // give me the data for row X
    func getClosePriceAt(row: Int)->Double {
        if let actualClosePrice = stockDataResults[row].close{
            return actualClosePrice
        }
        return 0
    }
    
    func getOpenPriceAt(row: Int)->Double {
        if let actualOpenPrice = stockDataResults[row].open{
            return actualOpenPrice
        }
        return 0
    }
    
    func searchWeeklyStockData(){
        
    }

    
    func searchStock(searchSymbol: String,
                     timeSpan: String, fromDate: String, toDate: String, completionHandler: (()->())? = nil )
    {
        //let searchSymbol = "APPL"
        let timeSpan = "day"
        let fromDate = "2022-04-04"
        let toDate = "2022-04-08"
        
        let theURL = createURL(searchSymbol: searchSymbol, timeSpan: timeSpan, fromDate: fromDate, toDate: toDate)
        
        // generate a url (with a search term)
        // get the JSON
        // parse the json
        
        parseJSONFromURL(theURL: theURL, completionHandler: completionHandler)
    }
    
    func parseJSONFromURL(theURL: URL?, completionHandler: (()->())? = nil){
        if theURL == nil {
            return
        }
        let session = URLSession(configuration: .ephemeral)
        //session.dataTask(with: <#T##URL#>, completionHandler: T##(Data?, URLResponse?, Error?) -> Void)
        // session.dataTask(with: theURL!)
        print("about to create a data task (4)")
        let dataTask = session.dataTask(with: theURL!) {
            (data, _, error) in
            if let actualError = error {
                print("We got an error (5a)")
            } else if let actualData = data
            {
                print("We got data (5b)")
                print("the data is \(actualData)")
                
                let theStockData: StockOuterJSON = try!
                JSONDecoder().decode(StockOuterJSON.self, from: actualData)
                var tempResultsArray = [StockData]()
                print("I've processed the JSON (5c)")
                
                if let actualTickerSymbol = theStockData.ticker
                {
                    self.tickerSymbol = actualTickerSymbol
                    if let actualStockDataResults = theStockData.results
                    {
                        for jsonStockData in actualStockDataResults
                        {
                            let actualClosePrice = Double(jsonStockData.closePrice!)
                            print("close price = \(actualClosePrice)")
                            let actualOpenPrice = Double(jsonStockData.openPrice!)
                            let actualVolume = Int64(jsonStockData.volume!)
                            let dataEntry = StockData(open: actualOpenPrice, close: actualClosePrice, volume: actualVolume)
                            tempResultsArray.append(dataEntry)
                    //print("\n and the close price is \(actualClosePrice)")
                        }
                    }
                    self.stockDataResults = tempResultsArray
                    print("checking the new array..")
                    print("close price index 1 = \(self.stockDataResults[1].close!)")
                }
                if (completionHandler != nil) {
                    DispatchQueue.main.async {
                        completionHandler?()
                    }
                }

            } // if actualData
        }
        print("I've create a data task (6)")
        dataTask.resume()
        print("I've run (7)")
    }

    
    // MARK: URL Processing
    
   // good alternative: private func createURL(searchTerm: String?)->URL?   {
    private enum URLAction {
        //case Recent
        case Search(String)
    }
    private func createURL(searchSymbol:String, timeSpan: String, fromDate: String, toDate:String)->URL?   {
        
        var baseURL = "https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2021-04-04/2021-04-08?adjusted=true&sort=asc&limit=120&apiKey=l_2LdaXmaULoUiL6WLJKskPuuELOKfxf"
        
        var baseURL2 = "https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2022-04-04/2022-04-08?adjusted=false&sort=desc&limit=119"
        
        var urlComponents = URLComponents(string: baseURL)
        //var queryItemArray = Array<URLQueryItem>()
         //queryItemArray.append(URLQueryItem(name: "apiKey", value: "l_2LdaXmaULoUiL6WLJKskPuuELOKfxf"))
        
        print("created URL (2)")
        //urlComponents?.queryItems = queryItemArray
        print("The returned URL is \(urlComponents?.string) (2)")
        
        return urlComponents?.url
    }
    
  
    private func getDailyClose()->URL? {
    
    //https://api.polygon.io/v1/open-close/AAPL/2020-10-14?adjusted=true&apiKey=l_2LdaXmaULoUiL6WLJKskPuuELOKfxf
    
    let stockStr = "/AAPL"
    let dateStr = "/2020-10-14"
    var baseURL = "https://api.polygon.io/v1/open-close"
    baseURL.append(stockStr)
    baseURL.append(dateStr)

    var urlComponents = URLComponents(string: baseURL)
    var queryItemArray = Array<URLQueryItem>()
    queryItemArray.append(URLQueryItem(name: "adjusted", value: "true"))
    queryItemArray.append(URLQueryItem(name: "apikey", value: "l_2LdaXmaULoUiL6WLJKskPuuELOKfxf"))
    
    urlComponents?.queryItems = queryItemArray
    print("The returned URL is \(urlComponents?.string!) (2)")
    print("created URL (2)")

    return urlComponents?.url
    
    }


    
}
