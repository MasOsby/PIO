//
//  ContentView.swift
//
//
//  Created by Mason Osby on 10/3/26.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ClosetView()
                .tabItem {
                    Label("Closet", systemImage: "hanger")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    ContentView()
}
