//
//  ReadData.swift
//  VeroDigital
//
//  Created by İbrahim Güler on 25.03.2023.
//

import Foundation
import SwiftUI
import CoreData

class ReadData: ObservableObject  {
    
    @Published var cats : [Cats] = []
  
    
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json")
        else {
            print("Json file not found")
            return
        }
        
        do{
            let data = try Data(contentsOf: url)
            self.cats = try JSONDecoder().decode([Cats].self, from: data)
        }
        catch  {
            print("hata var === \(error)")
        }
        
    }

    
    
    

    
}


