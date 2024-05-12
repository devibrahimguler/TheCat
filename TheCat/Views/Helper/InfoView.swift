//
//  InfoView.swift
//  TheCat
//
//  Created by İbrahim Güler on 8.04.2023.
//

import SwiftUI

struct InfoView: View {
    
    var items : [Info]
    
    var body: some View {
        ForEach(items) { item in
            if (item.subTitle != "") {
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(item.title) :")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("\(item.subTitle)")
                        .font(.body)
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    
                    Divider()
                        .padding(.bottom, 10)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
   
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
