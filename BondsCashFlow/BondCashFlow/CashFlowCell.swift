//
//  CashFlowCell.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowCell: View {
    @EnvironmentObject private var userData: UserData
    @Binding var hasData: Bool
    
    var start: Date
    var end: Date
    var cashFlow: CashFlow
    
    //    private var tableInCell: some View {
    //        TableInCell(instrument: self.cashFlow.instrument,
    //                    date: self.cashFlow.date,
    //                    type: self.cashFlow.type,
    //                    amount: self.cashFlow.amount)
    //    }
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            Spacer().frame(width: 6).fixedSize()
            
            VStack(alignment: .leading) {
                HStack{
                    Text(cashFlow.instrument.uppercased())
                        .fontWeight(.light)
                    
                    Spacer()
                    
                    // MARK:- добавить форматирование
                    // https://stackoverflow.com/questions/44630702/formatting-numbers-in-swift-3
                    Text(String(cashFlow.amount))
                        .fontWeight(.light)
                }
                .font(.footnote)
                
                HStack {
                    Text(cashFlow.date.toString())
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(cashFlow.type.id)
                        .foregroundColor(Color.orange)
                        .fontWeight(.light)
                }
                .font(.caption)
            }
                //            .onAppear(perform: { self.hasData = true })
                .padding(.vertical, 4)
        }
        .padding(.bottom, 6)
    }
}

#if DEBUG
struct CashFlowCell_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCell(hasData: .constant(true), start: Date(), end: Date().addWeeks(20), cashFlow: CashFlow(date: Date().addingTimeInterval(4000000), amount: 100000, instrument: "Мастер", type: .coupon))
            
            .previewLayout(.sizeThatFits)
            .environmentObject(UserData())
            .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
