//
//  cbondRequest.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

enum CBondError: Error {
    case wrongOperation, notOkResponse, decodingError, writeToFileError
}

//  MARK: - add filters to query
//  MARK: - add background option
func cbondRequest(login: String = "test", password: String = "test", limit: Int = 10, offset: Int = 0, cbondOperation: String = "get_flow") throws {
    
    //  could handle just "get_flow" or "get_emissions"
    //  get_emissions (параметры эмиссий)
    //  get_flow (потоки платежей)
    
    if !(cbondOperation == "get_flow" || cbondOperation == "get_emissions") {
        print("wrong cbond operation")
        throw CBondError.wrongOperation
    }
    
    let json = "{\"auth\":{\"login\":\"\(login)\",\"password\":\"\(password)\"},\"quantity\":{\"limit\":" + String(limit) + ",\"offset\":" + String(offset) + "}}"
    
    let url = URL(string: "https://ws.cbonds.info/services/json/" + cbondOperation + "/")!
    var request = URLRequest(url: url)
    request.httpMethod = "Post"
    request.httpBody = json.data(using: .utf8)
    
    
    //  MARK: - add background operation
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: request) {
        
        (data, response, error) in
        
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200,
            let data = data else {
                print("httpResponse statusCode IS NOT 200")
                return
        }
        
        if let postResponse = String(data: data, encoding: .utf8) {
            // print(postResponse)
            let jsonURL = URL(fileURLWithPath: cbondOperation,
                              relativeTo: FileManager.documentDirectoryURL)
                .appendingPathExtension("json")
            print(jsonURL)
            
            try! postResponse.write(to: jsonURL, atomically: true, encoding: .utf8)
        }
    }
    
    task.resume()
}
