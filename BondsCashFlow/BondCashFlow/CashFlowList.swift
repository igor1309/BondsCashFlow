//
//  CashFlowList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowList: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0 ..< 52) { weekNo in
                    CashFlowRow(weekNo: weekNo)
                        .environmentObject(self.userData)
                }
            }
        }
        .padding()
    }
}

#if DEBUG
struct CashFlowList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CashFlowList()
                .environmentObject(UserData())
                .navigationBarTitle("Cash Flow")
                .environment(\.sizeCategory, .extraLarge)
        }
    }
}
#endif
