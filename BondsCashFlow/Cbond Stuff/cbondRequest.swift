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

func cbondSession(background: Bool = false) -> URLSession {
    // MARK:- что еще для background operation??
    if background {
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "com.photoigor.bondscashflow.cbonds")
        return URLSession(configuration: backgroundConfiguration)
    } else {
        return URLSession(configuration: .default)
    }
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
    
    
    let url = URL(string: "https://ws.cbonds.info/services/json/" + cbondOperation + "/")!
    var request = URLRequest(url: url)
    request.httpMethod = "Post"
    
    let json = "{\"auth\":{\"login\":\"\(login)\",\"password\":\"\(password)\"},\"quantity\":{\"limit\":" + String(limit) + ",\"offset\":" + String(offset) + "}}"
    request.httpBody = json.data(using: .utf8)
    
    
    //  MARK: - TODO: add background operation
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
//             print(postResponse)
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
            
            //  prepare filename ("emissions" or "flow") and URL
            let filename = String(cbondOperation.split(separator: "_", maxSplits: 1)[1])
            let filenameURL = URL(fileURLWithPath: filename,
                                  relativeTo: FileManager.documentDirectoryURL)
                .appendingPathExtension("json")
            
            
            //  parse fetched data according to request
            
            if cbondOperation == "get_emissions" {   //  get_emissions (параметры эмиссий)
                do {
                    //  decode and take just the data we want
                    let cbondEmission = try decoder.decode(CBondGetEmission.self, from: data)
                    let emissionStructure = cbondEmission.items.map({ EmissionStructure(from: $0) })
                        .removingDuplicates()
                    
                    //  MARK: - TODO: parse header - could be valuable info there
                    //  ...
                    //  TODO: parse header - could be valuable info there
                    //        to be used to check if request is needed
                    print("count: \(cbondEmission.count), total: \(cbondEmission.total), execTime: \(cbondEmission.execTime)")

                    
                    //  encode and store useful data locally
                    let usefulData = try encoder.encode(emissionStructure)
                    try usefulData.write(to: filenameURL)
                    
                    print("fetched data parsed, optimized and saved\n" +
                        "emissionStructure.count: \(emissionStructure.count)")
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            if cbondOperation == "get_flow" {    //  get_flow (потоки платежей)
                do {
                    //  decode and take just the data we want
                    let cbondFlow = try decoder.decode(CBondGetFlow.self, from: data)
                    let cashFlowStructure = cbondFlow.items.map({ CashFlowStructure(from: $0) })
                        .removingDuplicates()
                    
                    //  MARK: - TODO: parse header - could be valuable info there
                    //  ...
                    //  TODO: parse header - could be valuable info there
                    //        to be used to check if request is needed
                    print("count: \(cbondFlow.count), total: \(cbondFlow.total), execTime: \(cbondFlow.execTime)")
                    
                    
                    
                    //  encode and store useful data locally
                    let usefulData = try encoder.encode(cashFlowStructure)
                    try usefulData.write(to: filenameURL)
                    
                    print("fetched data parsed, optimized and saved\n" +
                        "cashFlowStructure.count: \(cashFlowStructure.count)")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    task.resume()
}
