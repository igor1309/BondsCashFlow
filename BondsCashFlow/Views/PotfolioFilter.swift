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
    @EnvironmentObject var userData: UserData
    
    var portfolioNames: [String] {
        userData.portfolios.map({ $0.name })
    }
    
    var body: some View {
        NavigationView {
            Form {
                if userData.hasAtLeastTwoPortfolios {
                    Toggle(isOn: $userData.isAllPortfoliosSelected) {
                        Text("Все портфели")
                    }
                    
                    if !self.userData.isAllPortfoliosSelected {
                        Section {
                            Picker(selection: self.$userData.selectedPortfolio, label: Text("")//"Портфель")
                            ){
                                ForEach(portfolioNames, id: \.self) { name in
                                    Text(name).tag(name)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                    }
                } else {
                    EmptyView()
                }
            }
            .navigationBarTitle("Фильтр")
                
            .navigationBarItems(trailing: Button(action: {
                //  MARK: - add actions
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Закрыть")
            })
        }
    }
}

struct PotfolioFilter_Previews: PreviewProvider {
    static var previews: some View {
        PotfolioFilter()
            .environmentObject(UserData())
    }
}
