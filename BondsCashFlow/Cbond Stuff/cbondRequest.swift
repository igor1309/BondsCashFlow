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
func cbondRequest(login: String = "test", password: String = "test", limit: Int = 10, offset: Int = 0, cbondOperation: String = "get_flow", background: Bool = false) throws {
    
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
    //    let session = URLSession(configuration: .default)
    let session = cbondSession(background: background)
    let task = session.dataTask(with: request) {
        
        (data, response, error) in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
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
            
            //  store fetched data locally
            try! postResponse.write(to: jsonURL, atomically: true, encoding: .utf8)
            
            //  create JSON decoder
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.cbondDateFormatter)
            
            //  create JSON encoder
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            if cbondOperation == "get_emissions" {   //  get_emissions (параметры эмиссий)
                do {
                    let cbondEmission = try decoder.decode(CBondGetEmission.self, from: data)
                    //  MARK: - TODO: parse header - could be valuable info there
                    let item = cbondEmission.items[0]
                    let itemsData = try encoder.encode(item)
                    
                    let itemsURL = URL(fileURLWithPath: "get_emissions_items",
                                       relativeTo: FileManager.documentDirectoryURL)
                        .appendingPathExtension("json")
                    try itemsData.write(to: itemsURL)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            if cbondOperation == "get_flow" {    //  get_flow (потоки платежей)
                do {
                    let cbondFlow = try decoder.decode(CBondGetFlow.self, from: data)
                    //  MARK: - TODO: parse header - could be valuable info there
                    let item = cbondFlow.items[0]
                    let itemsData = try encoder.encode(item)
                    
                    let itemsURL = URL(fileURLWithPath: "get_flow_items",
                                       relativeTo: FileManager.documentDirectoryURL)
                        .appendingPathExtension("json")
                    try itemsData.write(to: itemsURL)
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    task.resume()
}

func cbondSession(background: Bool = false) -> URLSession {
    if background {
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "com.photoigor.bondscashflow.cbonds")
        return URLSession(configuration: backgroundConfiguration)
    } else {
        return URLSession(configuration: .default)
    }
}
