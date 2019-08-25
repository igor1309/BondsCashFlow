//
//  EmissionStructure.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmissionStructure: Hashable {
    let isinCode: String // Код ISIN Varchar
    let emitentNameRus: String // Эмитент (rus) Varchar
    let maturityDate: Date // Дата погашения Date
    let cupon_rus: String // Ставка купона (rus) Varchar
    let cupon_period: Int // Периодичность выплаты купона Int
    
    init(from: CBondEmission) {
        self.isinCode = from.isinCode
        self.emitentNameRus = from.emitentNameRus
        
        //  date @ get_emissions is optional string like 2011-03-28
        if from.maturityDate != nil {
            let dateComponents = DateComponents(year: Int(from.maturityDate!.prefix(4)),
                                                month: Int(from.maturityDate!.suffix(5).prefix(2)),
                                                day: Int(from.maturityDate!.suffix(2)))
            self.maturityDate = Calendar.current.date(from: dateComponents) ?? .distantPast
        } else {
            self.maturityDate = .distantPast
        }
        self.cupon_rus = from.cuponRus
        self.cupon_period = Int(from.cuponPeriod ?? "") ?? 0
    }
}
