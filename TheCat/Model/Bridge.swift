//
//  URL.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2023.
//

import SwiftUI

struct Bridge :Identifiable, Hashable {
    let id : UUID = UUID()
    let title : String
    let url : String
}
