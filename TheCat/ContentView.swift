//
//  IntroView.swift
//  TheCat
//
//  Created by İbrahim Güler on 16.04.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel : CatsListViewModel = CatsListViewModel()
    
    var body: some View {
        MainView()
            .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
