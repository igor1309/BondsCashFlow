//
//  Data.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

let cashFlowData = loadCashFlowData()

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
