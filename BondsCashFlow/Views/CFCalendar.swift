//
//  CFCalendar.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CFCalendar: View {
    @State private var showPortfolioFilter = false
    
    var body: some View {
        VStack {
            Text("это картинка ↓").foregroundColor(.systemRed)
            Image("cfcalendar")
            
        }
        .navigationBarTitle("Потоки")
            
        .navigationBarItems(trailing: Button(action: {
            self.showPortfolioFilter = true
        }) {
            Image(systemName: "line.horizontal.3.decrease.circle")
            
        })
            
            .sheet(isPresented: $showPortfolioFilter,
                   content: { PotfolioFilter() })
    }
}

struct CFCalendar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CFCalendar()
        }
    }
}
