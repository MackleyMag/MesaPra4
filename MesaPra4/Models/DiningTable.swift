//
//  DiningTable.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 28/06/24.
//

import SwiftData
import SwiftUI

@Model
class DiningTable {
    var title: String = ""
    var color: String
    var dateAdded: Date
    var tip: Decimal?
    var coverTip: Decimal?
    
    var totalAmount: Decimal?
    var isClosed: Bool = false
    var raiting: Int?
    
    @Relationship(deleteRule: .cascade)
    var diningItems: [DiningItem]?
    
    @Relationship(deleteRule: .cascade)
    var peopleInTable: [PersonInTable]?
    
    init(title: String, color: String, dateAdded: Date = Date.now, raiting: Int? = nil,
         tip: Decimal? = nil, coverTip: Decimal? = nil) {
        self.title = title
        self.color = color
        self.dateAdded = dateAdded
        self.raiting = raiting
        self.tip = tip
        self.coverTip = coverTip
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
