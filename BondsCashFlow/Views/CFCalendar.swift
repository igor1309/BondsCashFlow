//
//  CFCalendar.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CFCalendar: View {
    @EnvironmentObject var userData: UserData
    @State private var showPortfolioFilter = false
    
    var body: some View {
        VStack {
            Text("TBD")
            
        }
        .navigationBarTitle("Потоки")
            
        .navigationBarItems(trailing:
            Button(action: {
                self.showPortfolioFilter = true
            }) {
                Image(systemName: "briefcase")
            }
            .disabled(!self.userData.hasAtLeastTwoPortfolios))
            
        .sheet(isPresented: $showPortfolioFilter,
               content: { PotfolioFilter().environmentObject(self.userData) })
    }
}

struct CFCalendar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CFCalendar()
                .environmentObject(UserData())
        }
    }
}
