//
//  EmissionList.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

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
    
    @State private var filter: String = ""
    @State private var showFilter = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Фильтр по названию выпуска, ISIN",
                          text: $filter,
                          onEditingChanged: { isEdited in
                            
                }) {
                    
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                
                //  apply filter if at least 2 symbols entered
                if filter.count < 3 {
                    List {
                        ForEach(emissions.sorted(by: {
                            (($0.emitentNameRus, $0.documentRus, $0.isinCode)
                                < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
                            
                        }), id: \.self) { emission in
                            
                            EmissionRow(emission: emission)
                        }
                    }
                    
                } else {
                    List {
                        ForEach(emissions.sorted(by: {
                            (($0.emitentNameRus, $0.documentRus, $0.isinCode)
                                < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
                        }).filter({ $0.documentRus.contains(self.filter) ||
                            $0.documentRus.contains(self.filter.uppercased()) ||
                            $0.documentRus.contains(self.filter.lowercased()) ||
                            $0.documentRus.contains(self.filter.capitalized) ||
                            $0.isinCode.contains(self.filter.uppercased()) ||
                            $0.isinCode.contains(self.filter.lowercased()) ||
                            $0.isinCode.contains(self.filter.capitalized)
                            
                        }), id: \.self) { emission in
                            
                            EmissionRow(emission: emission)
                        }
                    }
                }
            }
            .navigationBarTitle("Выпуски")
                
            .navigationBarItems(leading: Button(action: {
                self.showFilter = true
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle")
                },
                                trailing: Button(action: {
                                    self.presentation.wrappedValue.dismiss()
                                }) {
                                    Text("Закрыть")
            })
                
                .sheet(isPresented: $showFilter,
                       content: { EmitentFilter(selectedEmitent: self.$filter) })
        }
    }
}

struct EmissionList_Previews: PreviewProvider {
    static var previews: some View {
        EmissionList()
    }
}
