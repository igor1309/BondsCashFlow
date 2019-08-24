//
//  CashFlowView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowView: View {
    @EnvironmentObject private var userData: UserData
    //    @State var baseDate = Date()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Base Date: " + userData.baseDate.toString())
                    .font(.footnote)
                    .foregroundColor(Color.secondary)
                    .padding(.horizontal)
                
                CashFlowGrid()
                    .environmentObject(self.userData)
                    .padding()
                    .environmentObject(self.userData)
                //                    .border(Color.red)
                
                CashFlowList()
                    .environmentObject(self.userData)
                    .padding(.horizontal, 11)
                    .environmentObject(self.userData)
                //                    .border(Color.red)
            }
                //                .padding(.horizontal)
                .navigationBarTitle("CF Calendar /week")
        }
    }
}

#if DEBUG
struct CashFlowView_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowView()
            .environmentObject(UserData())
        //        .preferredColorScheme(.dark)
    }
}
#endif
