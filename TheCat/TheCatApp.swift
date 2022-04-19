//
//  TheCatApp.swift
//  TheCat
//
//  Created by İbrahim Güler on 11.04.2022.
//

import SwiftUI

@main
struct TheCatApp: App {
    @ObservedObject var catsListViewModel = CatsListViewModel()
    var body: some Scene {
        WindowGroup {
            MainView(catsListViewModel: catsListViewModel)
        }
    }
}
