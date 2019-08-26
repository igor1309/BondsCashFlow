//
//  Catalogue.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Catalogue: View {
    @Environment(\.presentationMode) var presentation
    @State private var showLoginCredentials = false
    
    //  MARK: - change to userdata, store if changed
    //  MARK: use hash to store password
    @State private var login: String = "test"
    @State private var password: String = "test"
    
    //  MARK: - change to userdata, store if changed (UserDefaults)
    @State private var cbondOperation = "get_flow"  // get_emissions
    @State private var cbondLimit = 10
    @State private var cbondOffset = 0
    
    @State private var showConfirm = false
    
    @State private var process = ""
    
    var body: some View {
        Form {
            Section(header: Text("cbonds.ru".uppercased()),
                    footer: Text("")) {
                        HStack {
                            Text("Логин-пароль")
                            
                            Spacer()
                            
                            Text("\(login):\(password)")
                        }
                        .onTapGesture {
                            self.showLoginCredentials = true
                        }
                        
                        Picker(selection: $cbondOperation, label: Text("Операция")) {
                            Text("Потоки").tag("get_flow")
                            Text("Эмиссии").tag("get_emissions")
                        }
                        
                        Picker(selection: $cbondLimit, label: Text("Лимит запроса")) {
                            Text("1").tag(1)
                            Text("10").tag(10)
                            Text("50").tag(50)
                            Text("100").tag(100)
                            Text("500").tag(500)
                            Text("1000").tag(1000)
                        }
                        
                        Picker(selection: $cbondOffset, label: Text("Сдвиг")) {
                            Text("0").tag(0)
                            Text("10").tag(10)
                            Text("50").tag(50)
                            Text("100").tag(100)
                            Text("500").tag(500)
                            Text("1000").tag(1000)
                        }
                        
                        Text(process)
                        
            }
            
            Button(action: {
                self.showConfirm = true
            }) {
                Text("Запросить данные")
            }
            
        }
        .navigationBarTitle("Справочники")
            
        .navigationBarItems(trailing: Button(action: {
            self.showLoginCredentials = true
        }) {
            Image(systemName: "pencil.and.ellipsis.rectangle")
            
        })
            
            .actionSheet(isPresented: $showConfirm, content: { () -> ActionSheet in
                ActionSheet(title: Text("Точно?"),
                            message: Text("Операция займет время на получение данных и обработку."),
                            buttons: [
                                .cancel(Text("Отмена")),
                                .destructive(Text("Сделать запрос сейчас"), action: {
                                    //   MARK:- request data and save to file
                                    self.process = "Отправка запроса…"
                                    
                                    do {
                                        try cbondFetch(login: self.login,
                                                 password: self.password,
                                                 limit: self.cbondLimit,
                                                 offset: self.cbondOffset,
                                                 cbondOperation: self.cbondOperation)
//                                        self.process = "Данные получены"
                                    } catch {
                                        self.process = "Error getting data fron CBond."
                                    }
                                    
                                    
                                    //  запросить cbonds
                                    
                                    //                                    self.process = "Получение данных…"
                                    
                                    //                                    self.process = "Обработка…"
                                    
                                    //                                    self.process = "Сохранение данных…"
                                    
                                    
                                }),
                                //  MARK: - do it: background operation
                                .default(
                                    Text("Сделать запрос позже"), action: {
                                        //   MARK:- request data and save to file
                                })
                ])
            })
            
            .sheet(isPresented: $showLoginCredentials,
                   
                   //   MARK: - change to userdata
                //  MARK: use hash to store password
                content: { CbondLogin(login: self.$login, password: self.$password) })
    }
}
struct Catalogue_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Catalogue()
        }
    }
}
