//
//  CashFlowGridItem.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowGridItem: View {
    @State var itemState: ItemState
    
    let w: CGFloat = 32
    let h: CGFloat = 12
    let cornerRadius: CGFloat = 2
    
    var body: some View {
        var fillColor: Color
        var borderColor: Color
        
        switch itemState {
        case .empty:
            fillColor = .clear
            borderColor = .gray
        case .full:
            fillColor = .orange
            borderColor = .clear
            
        case .gray:
            fillColor = Color(hue: 0.0, saturation: 0, brightness: 0.7, opacity: 1)
            borderColor = .clear
            
        case .none:
            fillColor = .clear
            borderColor = .clear
        }
        
        return Rectangle()
            .fill(fillColor)
            .cornerRadius(cornerRadius)
            .frame(width: w, height: h)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .border(borderColor)
        //            .border(borderColor, cornerRadius: cornerRadius)
    }
}

#if DEBUG
struct CashFlowGridItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashFlowGridItem(itemState: .empty)
            CashFlowGridItem(itemState: .full)
            CashFlowGridItem(itemState: .none)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
