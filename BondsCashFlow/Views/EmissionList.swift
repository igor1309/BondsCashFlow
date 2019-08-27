//
//  EmissionList.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmissionRow: View {
    var emission: EmissionStructure
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(emission.documentRus)
            
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading) {
                    Text(emission.isinCode.isEmpty ? "isin -" : emission.isinCode)
                    
                    Text("emitentID " + emission.emitentID.formattedGrouped)
                    
                    Text(emission.emitentNameRus)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                VStack(alignment: .leading) {
                    Text("cupon_period " + emission.cupon_period.formattedGrouped)
                    
                    Text(emission.cupon_rus.isEmpty ? "-" : "cupon_rus " + emission.cupon_rus)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
        }
    }
}


struct EmissionList: View {
    @Environment(\.presentationMode) var presentation
    
    var emissions: [EmissionStructure] {
        if local {
            return loadEmissionListData()
        } else {
            return []
        }
    }
    var local = true
    
    var body: some View {
        NavigationView {
            List {
                ForEach(emissions.sorted(by: {
                    (($0.emitentNameRus, $0.documentRus, $0.isinCode)
                        < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
                }), id: \.self) {
                    
                    emission in
                    
                    EmissionRow(emission: emission)
                }
            }
            .navigationBarTitle("Выпуски")
                
            .navigationBarItems(trailing: Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Закрыть")
            })
        }
    }
}

struct EmissionList_Previews: PreviewProvider {
    static var previews: some View {
        EmissionList()
    }
}
