//
//  AddPosition.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct AddPosition: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @State private var qty = 1
    @State private var qtyErrorNote = ""
    
    private func validateQty() {
        if self.qty <= 0 {
            self.qtyErrorNote = "Количество облигаций должно быть положительным"
        } else {
            self.qtyErrorNote = ""
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Портфель".uppercased())) {
                    Picker(selection: .constant(1), label: Text("Портфель")) {
                        Text("Портфель 1").tag(1)
                        Text("Портфель 2").tag(2)
                    }
                }
                
                //  MARK: - а может брать Код выпуска из базы?
                //  или и то и другое?
                //  как проверять??
                Section(header: Text("Код выпуска (ISIN)".uppercased())) {
                    Picker(selection: .constant(1), label: Text("Код выпуска (ISIN)")) {
                        Text("Выпуск 1").tag(1)
                        Text("Выпуск 2").tag(2)
                    }
                }
                
                Section(header: Text("Количество".uppercased()),
                        footer: Text(qtyErrorNote).foregroundColor(.systemRed)) {
                            TextField("Количество",
                                      value: $qty,
                                      formatter: NumberFormatter(),
                                      onEditingChanged: { isEdited in
                                        self.validateQty()
                            }, onCommit: {
                                self.validateQty()
                            })
                                .keyboardType(.numberPad)
                }
            }
                
            .navigationBarTitle("Новая позиция")
                
            .navigationBarItems(
                leading: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Cancel").foregroundColor(.systemRed)
                },
                
                trailing: Button(action: {
                    //  MARK: - add actions and validations
                    self.validateQty()
                    
                    if self.qtyErrorNote.isEmpty {
                        self.presentation.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save")
            })
        }
    }
}

struct AddPosition_Previews: PreviewProvider {
    static var previews: some View {
        AddPosition()
            .environmentObject(UserData())
    }
}
