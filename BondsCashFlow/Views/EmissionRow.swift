//
//  EmissionRow.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmissionSubRow: View {
    //    @EnvironmentObject var userData: UserData
    
    var emission: EmissionStructure
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("id: " + emission.id.formattedGrouped)
                
                Spacer()
                
                Text(emission.emitentNameRus)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            
            Text(emission.documentRus)
            
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading) {
                    Text(emission.isinCode.isEmpty ? "isin -" : emission.isinCode)
                    
                    Text("emitentID " + emission.emitentID.formattedGrouped)
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

struct EmissionRow: View {
    @EnvironmentObject var userData: UserData
    
    var emission: EmissionStructure
    @State private var showDetail = false
    
    var body: some View {
        EmissionSubRow(emission: emission)
            //            .environmentObject(userData)
            .onTapGesture {
                self.showDetail = true
        }
            
        .sheet(isPresented: $showDetail, content: { EmissionDetail(emission: self.emission)
        .environmentObject(self.userData)
        })
    }
}

struct EmissionRow_Previews: PreviewProvider {
    static var previews: some View {
        EmissionRow(emission: EmissionStructure())
            .environmentObject(UserData())
    }
}
