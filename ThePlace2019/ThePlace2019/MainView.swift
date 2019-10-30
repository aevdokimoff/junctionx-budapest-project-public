//
//  MainView.swift
//  
//
//  Created by Paul Schmiedmayer on 10/10/19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            ContentView().tabItem({
                Image(systemName: "map.fill")
                Text("Map")
            })
            Favourites().tabItem({
                Image(systemName: "star.fill")
                Text("Favourites")
            })
        }
    }
}

// MARK: - MainViewPreviews
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
