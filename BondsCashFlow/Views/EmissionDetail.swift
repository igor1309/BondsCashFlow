//
//  EmissionDetail.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmissionDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var emission: EmissionStructure
    
    var flows: [CashFlowStructure] {
        userData.flows.filter({ $0.emissionID == emission.id }).sorted(by: { $0.couponNum < $1.couponNum })
    }
    
    //    var flows: [CashFlowStructure] {
    //        loadCashFlowListData().filter({ $0.emissionID == emission.id })
    //    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                EmissionSubRow(emission: emission)
                    .padding()
                
                Text("Потоки")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
                
                List {
                    ForEach(flows, id: \.self) { flow in
                        FlowRow(flow: flow)
                    }
                }
            }
                
            .navigationBarTitle("Выпуск")
                
            .navigationBarItems(trailing: Button(action: {
                //  MARK: - add actions
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Закрыть")
            })
        }
    }
}

struct EmissionDetail_Previews: PreviewProvider {
    static var previews: some View {
        EmissionDetail(emission: EmissionStructure())
            .environmentObject(UserData())
    }
}
