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
    
    @State private var filteredEmissions: [EmissionStructure] = loadEmissionListData().sorted(by: {
        (($0.emitentNameRus, $0.documentRus, $0.isinCode)
            < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
    })
    
    @State private var filter: String = "" {
        didSet {
            print("filter was set")
            //  apply filter if at least 2 symbols entered
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
            emissionsCount = filteredEmissions.count
            emitemtsCount = filteredEmissions.map({ $0.emitentID }).removingDuplicates().count
        }
    }
    
    @State private var preFilter: String = ""
    @State private var showFilter = false
    
    @State private var emissionsCount: Int = loadEmissionListData().count
    @State private var emitemtsCount: Int = loadEmissionListData().map({ $0.emitentID }).removingDuplicates().count
    
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
                
                Text("\(emissionsCount.formattedGrouped) выпуска/ов, \(emitemtsCount.formattedGrouped) эмитент/а/ов")
                    //  MARK: - одна из обций должна работать - не обрезать текст
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .padding(.horizontal)
                
                List {
                    ForEach(filteredEmissions, id: \.self) { emission in
                        
                        EmissionRow(emission: emission)
                    }
                }
            }
            .navigationBarTitle("Эмиссии")
                
            .navigationBarItems(
                leading: Button(action: {
                    self.showFilter = true
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
                       content: { EmitentFilter(filter: self.$preFilter) })
        }
    }
}

struct EmissionList_Previews: PreviewProvider {
    static var previews: some View {
        EmissionList()
            .environmentObject(UserData())
    }
}
