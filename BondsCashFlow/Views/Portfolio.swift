//
//  Portfolio.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Portfolio: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var showActions = false
    
    @State private var showModal = false
    @State private var modal: Modal = .filter
    private enum Modal { case filter, addPortfolio, addPosition, addIssue }
    
    
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
            
        }
        .navigationBarTitle("Портфели")
            
        .navigationBarItems(
            leading: Button(action: {
                self.showActions = true
            }) {
                Image(systemName: "plus")
            },
            
            trailing: Button(action: {
                self.modal = .filter
                self.showModal = true
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle")
                
        })
            
            .actionSheet(isPresented: $showActions, content: {
                ActionSheet(title: Text("Добавить"),
                            //                            message: Text(""),
                    buttons: [
                        .cancel(Text("Отмена")),
                        .default(Text("Добавить позицию в портфель"),
                                 action: {
                                    self.modal = .addPosition
                                    self.showModal = true }),
                        .default(Text("Добавить выпуск облигаций"),
                                 action: {
                                    self.modal = .addIssue
                                    self.showModal = true }),
                        .default(Text("Создать новый портфель"),
                                 action: {
                                    self.modal = .addPortfolio
                                    self.showModal = true })
                ])
            })
            
            .sheet(isPresented: $showModal, content: {
                if self.modal == .addPortfolio { AddPortfolio() }
                
                if self.modal == .addPosition { AddPosition() }
                
                if self.modal == .addIssue { AddIssue() }
                
                if self.modal == .filter { PotfolioFilter() }
            })
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Portfolio()
        }
    }
}
