//
//  OnBoardingPage.swift
//  Complete E-Commerce App UI
//
//  Created by Boris Zinovyev on 24.01.2022.
//

import SwiftUI

struct MainPage: View {
    
//    init() {
//        UITabBar.appearance().isHidden = true
//    }
    
    var body: some View {
        TabView {
//MARK: - HomeTab
            Home()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
//MARK: - LikedTab
            Liked()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Liked")
                }
//MARK: - ProfileTab
            Profile()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
//MARK: - CartTab
            Cart()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
            }
        }
    }
}

