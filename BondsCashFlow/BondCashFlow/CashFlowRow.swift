//
//  CashFlowRow.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowRow: View {
    @EnvironmentObject private var userData: UserData
    @State private var hasData = false
    
    var weekNo: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            
            //  MARK:- ПРОБЛЕМА: при изменении baseDate ZStack с боковой полосой с пустыми или заполненными точками НЕ ПЕРЕРИСОВЫВАЕТСЯ!!
            TimelineGraphForRow(hasData: hasData)
            
            VStack(alignment: .leading, spacing: 1) {
                Text(self.userData.baseDate.addWeeks(weekNo).firstDayOfWeekRU.toString()) // + " (W\(weekNo))")
                    .font(.caption).foregroundColor(.orange).fontWeight(.light)
                
                ForEach(self.userData.cashFlows) { cashFlow in
                    
                    if (self.userData.baseDate.addWeeks(self.weekNo).firstDayOfWeekRU <= cashFlow.date)
                        && (cashFlow.date <= self.userData.baseDate.addWeeks(self.weekNo + 1).firstDayOfWeekRU)
                    {
                        CashFlowCell(hasData: self.$hasData,
                                     start: self.userData.baseDate.addWeeks(self.weekNo).firstDayOfWeekRU,
                                     end: self.userData.baseDate.addWeeks(self.weekNo + 1).firstDayOfWeekRU,
                                     cashFlow: cashFlow)
                            .environmentObject(self.userData)
                            .onAppear(perform: { self.hasData = true })
                        
                    }
                }
            }
        }
    }
}


#if DEBUG
struct CashFlowRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashFlowRow(weekNo: 6)
                .environment(\.sizeCategory, .extraExtraLarge)
            
            CashFlowRow(weekNo: 8)
        }
        .environmentObject(UserData())
            .previewLayout(.sizeThatFits)
    }
}
#endif
