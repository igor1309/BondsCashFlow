//
//  CashFlowGrid.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowGrid: View {
    @EnvironmentObject private var userData: UserData
//    @Binding var baseDate: Date
    @State var activeWeek = 0
    
    let date = Date().firstDayOfWeekRU
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 3) {
                    ForEach(0..<52) { item in
                        CashFlowGridColumn(activeWeek: self.$activeWeek, weekNo: item, date: self.date)
                            .environmentObject(self.userData)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct CashFlowGrid_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashFlowGrid()
                .padding()
            
            CashFlowGrid()
                .padding()
                .preferredColorScheme(.dark)
        }
        .environmentObject(UserData())
    }
}
#endif
