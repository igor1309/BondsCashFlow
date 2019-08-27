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
    @Binding var filter: String
//    @State private var selectedEmitent: String = loadEmissionListData().map({ $0.emitentNameRus }).removingDuplicates().sorted()[0]
    
    var emitents: [String] {
        loadEmissionListData().map({ $0.emitentNameRus }).removingDuplicates().sorted()
    }
    
    var body: some View {
        //  фильтр по эмитенту
        NavigationView {
            Form {
                Text("Эмитент")
                Picker(selection: $filter, label: Text("")//Фильтр по эмитенту")
                ){
                    ForEach(emitents, id: \.self){ name in
                        Text(name).tag(name)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
                //  MARK: - TODO do it
                Toggle(isOn: .constant(true)) {
                    Text("TBD: Только выпуски с потоками").foregroundColor(.systemRed)
                }
            }
                
            .navigationBarTitle("Фильтр")
                
            .navigationBarItems(trailing: Button(action: {
                //  MARK: - add actions
//                print("filter: " + self.filter)
//                print("selectedEmitent: " + self.selectedEmitent)
//                self.filter = self.selectedEmitent
                self.presentation.wrappedValue.dismiss()

//                print("filter: " + self.filter)
//                print("selectedEmitent: " + self.selectedEmitent)

            }) {
                Text("Закрыть")
            })
            
        }
    }
}

struct EmitentFilter_Previews: PreviewProvider {
    static var previews: some View {
        EmitentFilter(filter: .constant(""))
    }
}
