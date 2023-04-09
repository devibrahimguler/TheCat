//
//  MainView.swift
//  TheCat
//
//  Created by İbrahim Güler on 11.04.2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel : CatsViewModel
    
    
    var body: some View {
        if viewModel.cats?.count == 0 {
            PlaceHolder()
                .onAppear {
                    self.viewModel.basicDownloader()
                    self.viewModel.favoriteCats()
                }
        } else {
            Home()
                .environmentObject(viewModel)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
