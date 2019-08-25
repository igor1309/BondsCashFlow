//
//  CbondLogin.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CbondLogin: View {
    @Environment(\.presentationMode) var presentation
    
    @Binding var login: String
    @Binding var password: String
    @State var footer = "Тестовый доступ по test:test"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Доступ к cbonds.ru".uppercased()),
                                     footer: Text(footer)
                ){
                    TextField("Логин", text: $login)
                    TextField("Пароль", text: $password)
                }
                
                Button(action: {
                    self.login = "test"
                    self.password = "test"
                    self.footer = "Тестовый доступ по test:test"
                }) {
                    Text("Сбросить")
                }
                
            }
            .navigationBarTitle("Логин-пароль")
                
            .navigationBarItems(trailing: Button(action: {
                //  MARK: - add actions
                if self.login.isNotEmpty && self.password.isNotEmpty {
                    self.presentation.wrappedValue.dismiss()
                } else {
                    self.footer = "Логин-пароль не могут быть пустыми"
                }
            }) {
                Text("Закрыть")
            })
        }
        
    }
}

struct CbondLogin_Previews: PreviewProvider {
    static var previews: some View {
        CbondLogin(login: .constant("test"),
                   password: .constant("test"))
    }
}
