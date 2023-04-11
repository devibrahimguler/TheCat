//
//  IntroView.swift
//  TheCat
//
//  Created by İbrahim Güler on 16.04.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel : CatsViewModel = CatsViewModel()
    
    var body: some View {
        Home()
            .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
