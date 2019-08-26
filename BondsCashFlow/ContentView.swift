//
//  ContentView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection){
            
            NavigationView {
                CFCalendar()
            }
            .tabItem {
                VStack {
                    Image(systemName: "calendar")
                    Text("Календарь")
                }
            }
            .tag(0)
            
            NavigationView {
                PortfolioView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "briefcase.fill")
                    Text("Портфели")
                }
            }
            .tag(1)
            
            NavigationView {
                Catalogue()
            }
            .tabItem {
                VStack {
                    Image(systemName: "tray.2.fill")
                    Text("Справочники")
                }
            }
            .tag(2)
            
            NavigationView {
                Settings()
            }
            .tabItem {
                VStack {
                    Image(systemName: "gear")
                    Text("Настройки")
                }
            }
            .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
