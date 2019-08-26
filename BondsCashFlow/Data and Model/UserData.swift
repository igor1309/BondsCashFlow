//
//  UserData.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//
//  A model object that stores app data.


import Foundation

final class UserData: ObservableObject {
    private let defaults = UserDefaults.standard
    
    @Published var portfolios: [Portfolio] = portfolioData {
        didSet {
            saveJSON(data: portfolios, filename: "portfolios.json")
        }
    }
    
    var hasAtLeastTwoPortfolios: Bool {
        portfolios.count > 1
    }
    
    //  фильтры ломаются, поэтому всегда стартуем со всех портфелей
    @Published var isAllPortfoliosSelected: Bool = true || UserDefaults.standard.bool(forKey: "isAllPortfoliosSelected") {
        didSet {
            defaults.set(isAllPortfoliosSelected, forKey: "isAllPortfoliosSelected")
        }
    }
    
    @Published var selectedPortfolio: String = UserDefaults.standard.string(forKey: "selectedPortfolio") ?? "" {
        didSet {
            defaults.set(selectedPortfolio, forKey: "selectedPortfolio")
        }
    }
    
    @Published var cashFlows = cashFlowData
    
    @Published var baseDate = Date()
}
