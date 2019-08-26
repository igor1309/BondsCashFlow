//
//  PositionRow.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionRow: View {
    var portfolioName: String
    var position: Position
    
    public var borderColor: Color = .systemGray
    public var cornerRadius: CGFloat = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(position.isin)
                
                Spacer()
                
                Text(position.qty.formattedGrouped)
            }
            
            HStack {
                Text(portfolioName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
    }
}

struct PositionRow_Previews: PreviewProvider {
    static var previews: some View {
        PositionRow(portfolioName: "Bumblebee",
                    position: Position(isin: "RU000A0ZZAR2", qty: 5555))
    }
}
