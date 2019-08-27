//
//  EmissionRow.swift
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

//struct EmissionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        EmissionRow(EmissionStructure())
//    }
//}
