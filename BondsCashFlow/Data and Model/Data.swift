//
//  Data.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

let portfolioData = loadPortfolioData()

let cashFlowData = loadCashFlowData()


func loadPortfolioData() -> [Portfolio] {
    guard let data: [Portfolio] = loadFromDocDir("porfolios.json") else {
        return [
            Portfolio(name: "Bumblebee",
                      positions: [
                        Position(isin: "RU000A0ZZAR2", qty: 12139),
                        Position(isin: "RU000A100HW3", qty: 1096),
                        Position(isin: "RU000A100E70", qty: 89)
            ]),
            Portfolio(name: "Megatron",
                      positions: [
                        Position(isin: "RU000A100HW3", qty: 10),
                        Position(isin: "RU000A100E70", qty: 1)
            ])

        ]
    }
    
    return data
}

func loadCashFlowData() -> [CashFlow] {
    return [
        CashFlow(date: Date().firstDayOfWeekRU.addDays(0), amount: 100000, instrument: "Мастер", type: .coupon),
        CashFlow(date: Date().firstDayOfWeekRU.addDays(2), amount: 10000, instrument: "Ломбард", type: .face),
        
        CashFlow(date: Date().addWeeks(1).firstDayOfWeekRU.addDays(3), amount: 200000, instrument: "Ломбард", type: .coupon),
        
        CashFlow(date: Date().addWeeks(2).firstDayOfWeekRU.addDays(2), amount: 200000, instrument: "Мастер", type: .face),
        CashFlow(date: Date().addWeeks(2).firstDayOfWeekRU.addDays(2), amount: 100000, instrument: "Мастер", type: .coupon),
        
        CashFlow(date: Date().addWeeks(3).firstDayOfWeekRU.addDays(1), amount: 10000, instrument: "Ломбард", type: .face),
        CashFlow(date: Date().addWeeks(5).firstDayOfWeekRU.addDays(3), amount: 200000, instrument: "Ломбард", type: .coupon),
        CashFlow(date: Date().addWeeks(8).firstDayOfWeekRU.addDays(3), amount: 200000, instrument: "Ломбард", type: .face),
        CashFlow(date: Date().addWeeks(15).firstDayOfWeekRU.addDays(4), amount: 200000, instrument: "Мастер", type: .coupon),
        CashFlow(date: Date().addWeeks(19).firstDayOfWeekRU.addDays(0), amount: 200000, instrument: "Мастер", type: .coupon),
        CashFlow(date: Date().addWeeks(26).firstDayOfWeekRU.addDays(1), amount: 200000, instrument: "Ломбард", type: .coupon)
    ]
}
