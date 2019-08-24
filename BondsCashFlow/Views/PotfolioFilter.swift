//
//  PotfolioFilter.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PotfolioFilter: View {
    @Environment(\.presentationMode) var presentation
    
    //  MARK: - change to observable object and userData
    @State var isAllPortfoliosSelected = true
    @State var selectedPortfolio: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $isAllPortfoliosSelected) {
                    Text("Все портфели")
                }
                
                Section {
                    
                    if !isAllPortfoliosSelected {
                        //  MARK: - change to portfilo names
                        Picker(selection: $selectedPortfolio, label: Text("Портфель")
                        ){
                            Text("Портфель 1").tag(1)
                            Text("Портфель 2").tag(2)
                            Text("Портфель 3").tag(3)
                            Text("Портфель 4").tag(4)
                        }
                    }
                }
            }
            .navigationBarTitle("Фильтр")
                
            .navigationBarItems(trailing: Button(action: {
                    //  MARK: - add actions
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Done")
            })
        }
    }
}

struct PotfolioFilter_Previews: PreviewProvider {
    static var previews: some View {
        PotfolioFilter()
    }
}
