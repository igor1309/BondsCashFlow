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
    @EnvironmentObject var userData: UserData
    
    var local = true
    
    @State private var filteredEmissions: [EmissionStructure] = []
    
    @State private var filter: String = "460" {//5165
        didSet {
            if filter.count < 2 {
                filteredEmissions = userData.emissions.sorted(by: {
                    (($0.emitentNameRus, $0.documentRus, $0.isinCode)
                        < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
                })
            } else {
                filteredEmissions = userData.emissions.sorted(by: {
                    (($0.emitentNameRus, $0.documentRus, $0.isinCode)
                        < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
                }).filter({ $0.documentRus.contains(self.filter) ||
                    $0.documentRus.contains(self.filter.uppercased()) ||
                    $0.documentRus.contains(self.filter.lowercased()) ||
                    $0.documentRus.contains(self.filter.capitalized) ||
                    $0.isinCode.contains(self.filter) ||
                    $0.isinCode.contains(self.filter.uppercased()) ||
                    $0.isinCode.contains(self.filter.lowercased()) ||
                    $0.isinCode.contains(self.filter.capitalized) ||
                    $0.id == Int(filter) ?? -1
                })
            }
        }
    }
    
    @State private var preFilter: String = "460"
    @State private var showFilter = false
    
    @State private var emissionsCount: Int = 0
    @State private var emitemtsCount: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Фильтр по названию выпуска, ISIN",
                          text: $preFilter,
                          onEditingChanged: { isEdited in
                            
                }) {
                    self.filter = self.preFilter
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                
                Text("\(emissionsCount.formattedGrouped) выпусков, \(emitemtsCount.formattedGrouped) эмитентов.")
                    //  MARK: - одна из обций должна работать - не обрезать текст
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .padding(.horizontal)
                
                //  apply filter if at least 2 symbols entered
                if filter.count < 2 {
                    List {
                        ForEach(userData.emissions.sorted(by: {
                            (($0.emitentNameRus, $0.documentRus, $0.isinCode)
                                < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
                            
                        }), id: \.self) { emission in
                            
                            EmissionRow(emission: emission)
                        }
                        .onAppear {
                            self.emissionsCount = self.userData.emissions.count
                            self.emitemtsCount = self.userData.emissions.map({ $0.emitentID }).removingDuplicates().count
                        }
                    }
                    
                } else {
                    List {
                        ForEach(userData.emissions.sorted(by: {
                            (($0.emitentNameRus, $0.documentRus, $0.isinCode)
                                < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
                        }).filter({ $0.documentRus.contains(self.filter) ||
                            $0.documentRus.contains(self.filter.uppercased()) ||
                            $0.documentRus.contains(self.filter.lowercased()) ||
                            $0.documentRus.contains(self.filter.capitalized) ||
                            $0.isinCode.contains(self.filter) ||
                            $0.isinCode.contains(self.filter.uppercased()) ||
                            $0.isinCode.contains(self.filter.lowercased()) ||
                            $0.isinCode.contains(self.filter.capitalized) ||
                            $0.id == Int(filter) ?? -1
                            
                        }), id: \.self) { emission in
                            
                            EmissionRow(emission: emission)
                        }
                        .onAppear {
                            self.emissionsCount = self.userData.emissions.count
                            self.emitemtsCount = self.userData.emissions.map({ $0.emitentID }).removingDuplicates().count
                        }
                    }
                }
            }
            .navigationBarTitle("Эмиссии")
                
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
                       content: { EmitentFilter(filter: self.$filter) })
        }
    }
}

struct EmissionList_Previews: PreviewProvider {
    static var previews: some View {
        EmissionList()
            .environmentObject(UserData())
    }
}
