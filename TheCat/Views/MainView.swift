//
//  MainView.swift
//  TheCat
//
//  Created by İbrahim Güler on 11.04.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var catsListViewModel : CatsListViewModel
    
    init(catsListViewModel : CatsListViewModel) {
        self.catsListViewModel = catsListViewModel
    }
    
    var body: some View {
        if catsListViewModel.cats.count == 0 {
            PlaceHolder()
                .onAppear {
                    self.catsListViewModel.basicDownloader()
                    self.catsListViewModel.favoriteCats()
                }
        } else {
            SearchCats(catsListViewModel: catsListViewModel)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Test_MainView()
    }
    
    struct Test_MainView : View {
        @ObservedObject var catsListViewModel = CatsListViewModel()
        
        var body: some View {
            MainView(catsListViewModel: catsListViewModel)
        }
    }
}
