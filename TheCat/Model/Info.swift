//
//  Info.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2023.
//

import SwiftUI

struct Info :Identifiable, Hashable {
    let id : UUID = UUID()
    let title : String
    let subTitle : String
}
