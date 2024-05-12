//
//  SubPropertyView.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2023.
//

import SwiftUI

struct SubPropertyView: View {
    
    var title : String
    var titleArray : [String]

    init(title: String, subTitle: String) {
        self.title = title
        self.titleArray = subTitle.components(separatedBy: ",")
    }
    var body: some View {
        if !(titleArray.isEmpty) {
            VStack(alignment: .leading, spacing: 10) {
                Text("\(title) :")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                
                ForEach(titleArray, id: \.self) { item in
                    HStack(spacing: 5) {
                        
                        Image(systemName: "rhombus.fill")
                            .font(.system(size: 7, weight: .ultraLight))
                        
                        Text("\(item.trimmingCharacters(in: [" "]))")
                            .font(.body)
                            .foregroundColor(.gray)
                            .lineLimit(nil)
                        
                    }
                    .padding(.leading, 30)
                }
                
                Divider()
                    .padding(.bottom, 10)
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

struct SubPropertyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
