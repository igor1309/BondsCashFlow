//
//  Potfolio.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 26.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Portfolio: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var name: String
    var positions: [Position]
    
    init() {
        self.name = "Portfolio"
        self.positions = []
    }
    
    init(name: String, positions: [Position]) {
        self.name = name
        self.positions = positions
    }
}

struct Position: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var isin: String = ""
    var qty: Int = 0
    
    init() {
        self.isin = "RU000A0ZZAR2"
        self.qty = 0
    }
    
    init(isin: String, qty: Int) {
        self.isin = isin
        self.qty = qty
    }
}
