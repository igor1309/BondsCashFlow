//
//  PortfolioView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionRow: View {
    var portfolioName: String
    var position: Position
    
    public var borderColor: Color = .systemGray
    public var cornerRadius: CGFloat = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(position.isin)
                
                Spacer()
                
                Text(position.qty.formattedGrouped)
            }
            
            HStack {
                Text(portfolioName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
    }
}

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var portfolioNames: [String] { userData.portfolios.map({ $0.name }) }
    
    @State private var showActions = false
    @State private var showModal = false
    @State private var modal: Modal = .filter
    
    private enum Modal {
        case filter, addPortfolio, addPosition, addIssue
    }
    
    var body: some View {
        List {
            if userData.isAllPortfoliosSelected {
                ForEach(userData.portfolios) { portfolio in
                    ForEach(portfolio.positions) { position in
                        PositionRow(portfolioName: portfolio.name,
                                    position: position)
                    }
                }
            } else {
                if userData.selectedPortfolio.isNotEmpty {
                    ForEach(userData.portfolios.first(where: { $0.name == self.userData.selectedPortfolio })!.positions, id: \.self) { position in
                        PositionRow(portfolioName: self.userData.selectedPortfolio,
                                    position: position)
                    }
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
            }
        }
        .navigationBarTitle("Портфели")
            
        .navigationBarItems(
            leading: Button(action: {
                self.showActions = true
            }) {
                Image(systemName: "plus")
            },
            
            trailing: Button(action: {
                if self.userData.hasAtLeastTwoPortfolios {
                    self.modal = .filter
                    self.showModal = true
                }
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle")
            }
            .disabled(!self.userData.hasAtLeastTwoPortfolios)
        )
            
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
                if self.modal == .addPortfolio {
                    AddPortfolio().environmentObject(self.userData)
                }
                
                if self.modal == .addPosition {
                    AddPosition().environmentObject(self.userData)
                }
                
                if self.modal == .addIssue {
                    AddIssue().environmentObject(self.userData)
                }
                
                if self.modal == .filter {
                    PotfolioFilter().environmentObject(self.userData)
                }
            })
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PortfolioView()
        }
        .environmentObject(UserData())
    }
}
