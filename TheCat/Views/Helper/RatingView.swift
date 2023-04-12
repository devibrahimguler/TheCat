//
//  RatingView.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2023.
//

import SwiftUI

struct RatingView: View {
    var items : [Rating]
    
    var body: some View {
        ForEach(items, id:\.self) { item in
            if (item.rating != 0) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    
                    HStack(spacing: 4) {
                        
                        Text("\(item.title) :")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 5)
                        
                        ForEach(1...5, id:\.self) { index in
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(index <= item.rating ? .yellow : .gray.opacity(0.5))
                        }
    
                        Text("(\(item.rating))")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.yellow)
                            .padding(.leading, 5)
                        
                    }
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
               
            }
        }
    }
}
