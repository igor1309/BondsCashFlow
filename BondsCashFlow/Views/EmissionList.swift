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
    
    @State private var preFilter: String = ""
    @State private var filter: String = ""
    @State private var filterType: FilterType = .withFlows
    
    private enum FilterType: String, CaseIterable {
        case all = "Все"
        case withFlows = "С потоками"
        //  MARK: TODO додумать и доделать
        case emitent = "Эмитент"
        case complex = "Текст"
    }
    
    @State private var showFilter = false
    
    //  MARK: TODO доделать
    @State private var emissionsCount: Int = loadEmissionListData().count
    @State private var emitemtsCount: Int = loadEmissionListData().map({ $0.emitentID }).removingDuplicates().count
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Picker(selection: $filterType, label: Text("")) {
                    ForEach(FilterType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                if filterType == FilterType.complex {
                    TextField("Фильтр по названию выпуска, ISIN",
                              text: $preFilter,
                              onEditingChanged: { isEdited in
                    },
                              onCommit: {
                                if self.preFilter.count < 2 {
                                    self.filterType = .all
                                } else {
                                    self.filterType = .complex
                                }
                                self.filter = self.preFilter
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                

                //  MARK: TODO доделать
//                Text("\(emissionsCount.formattedGrouped) выпуск/а/ов, \(emitemtsCount.formattedGrouped) эмитент/а/ов")
//                    //  MARK: - одна из опций должна работать (не обрезать текст)
//                    .lineLimit(nil)
//                    .fixedSize(horizontal: false, vertical: true)
//                    .foregroundColor(.secondary)
//                    .font(.subheadline)
//                    .padding(.horizontal)
                
                
                List {
                    //  apply filter if at least 2 symbols entered
                    ForEach(userData.emissions.filter({
                        
                        switch filterType {
                        case .all:
                            return true
                        case .emitent:
                            return $0.emitentNameRus == filter
                        case .complex:
                            return $0.documentRus.contains(self.filter) ||
                                $0.documentRus.contains(self.filter.uppercased()) ||
                                $0.documentRus.contains(self.filter.lowercased()) ||
                                $0.documentRus.contains(self.filter.capitalized) ||
                                $0.isinCode.contains(self.filter) ||
                                $0.isinCode.contains(self.filter.uppercased()) ||
                                $0.isinCode.contains(self.filter.lowercased()) ||
                                $0.isinCode.contains(self.filter.capitalized) ||
                                $0.id == Int(filter) ?? -1
                        case .withFlows:
                            return userData.flows.map { $0.emissionID }.contains($0.id)
                        }
                        
                    }).sorted(by: {
                        (($0.emitentNameRus, $0.documentRus, $0.isinCode)
                            < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
                    }), id: \.self) { emission in
                        
                        EmissionRow(emission: emission)
                    }
                }
            }
            .navigationBarTitle("Эмиссии")
                
            .navigationBarItems(
                leading: Button(action: {
                    self.showFilter = true
                    self.filterType = .emitent
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                },
                
                trailing: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Закрыть")
            })
                
                //  по свайпу закрывания модала работает
                //  фильт меняется и didSet происходит
                //  и обновляется таблица, но
                //  не работает когда в EmitentFilter вызывается self.presentation.wrappedValue.dismiss()
                //  либо баг либо нет
                //  решения пока не видно
                .sheet(isPresented: $showFilter,
                       onDismiss: {
                        self.filter = self.preFilter
                },
                       content: { EmitentFilter(filter: self.$filter,
                                                preFilter: self.$preFilter) })
        }
    }
}

struct EmissionList_Previews: PreviewProvider {
    static var previews: some View {
        EmissionList()
            .environmentObject(UserData())
    }
}
