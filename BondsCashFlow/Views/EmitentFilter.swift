//
//  EmitentFilter.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmitentFilter: View {
    @Environment(\.presentationMode) var presentation
    @Binding var selectedEmitent: String
    
    var emitents: [String] {
        loadEmissionListData().map({ $0.emitentNameRus }).removingDuplicates().sorted()
    }
    
    var body: some View {
        //  фильтр по эмитенту
        NavigationView {
            VStack {
                Picker(selection: $selectedEmitent, label: Text("")//Фильтр по эмитенту")
                ){
                    ForEach(emitents, id: \.self){ name in
                        Text(name).tag(name)
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Эмитенты")
                
            .navigationBarItems(trailing: Button(action: {
                //  MARK: - add actions
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Закрыть")
            })
            
        }
    }
}

struct EmitentFilter_Previews: PreviewProvider {
    static var previews: some View {
        EmitentFilter(selectedEmitent: .constant(""))
    }
}
