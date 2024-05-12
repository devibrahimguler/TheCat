//
//  PlaceHolder.swift
//  TheCat
//
//  Created by İbrahim Güler on 16.04.2022.
//

import SwiftUI

struct PlaceHolder: View {
    
    @State var rotation = 30.0
    
    var body: some View {
        ZStack{
            Image("placeholder")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
                .rotationEffect(Angle(degrees: rotation))
                .animation(.easeOut.repeatForever(), value: rotation)
        }.onAppear {
            self.rotation = self.rotation == 30 ? self.rotation - 60 : self.rotation + 60
        }
    }
}

struct PlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        PlaceHolder()
    }
}
