//
//  TimelineGraphForRow.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct TimelineGraphForRow: View {
    var hasData: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .frame(minWidth: 1, idealWidth: 1, maxWidth: 1,
                       minHeight: 16, idealHeight: 32, maxHeight: .infinity,
                       alignment: .top)
                .offset(x: 4)
                .foregroundColor(Color.orange)
            
            Circle()
                // MARK:- земенить на семантический UIColor.systemBackground
                .fill(hasData ? Color.orange : Color.white)
//                .onAppear(perform: { print("hasData: \(self.hasData)") })
                .overlay(Circle().stroke(Color.orange))
                .frame(width: 7, height: 7)
                //  overlay with stroke adds extra size need to x-offset to compensate
                .offset(x:1, y: 4)
        }
    }
}

#if DEBUG
struct TimelineGraphForRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimelineGraphForRow(hasData: true)
            
            TimelineGraphForRow(hasData: false)
            //                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
