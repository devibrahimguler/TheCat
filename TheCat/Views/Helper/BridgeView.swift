//
//  URLView.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2023.
//

import SwiftUI

struct BridgeView: View {
    var items : [Bridge]
    
    var body: some View {
        ForEach(items) { item in
            if (item.url != "") {
                HStack(spacing: 5) {
                    Link(destination: URL(string: item.url)!) {
                        Image(systemName: "rhombus.fill")
                            .font(.system(size: 7, weight: .ultraLight))
                        
                        Text("\(item.title)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black.opacity(0.7))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
            }
        }
        
    }
}

struct BridgeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
