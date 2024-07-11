//
//  PersonInTable.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 02/07/24.
//

import SwiftData
import SwiftUI

@Model
class PersonInTable {
    var personName: String
    var color: String
    
    var diningTable: DiningTable?
    
    @Relationship(inverse: \DiningItem.people) var diningItems: [DiningItem]?
    
    init(personName: String, color: String) {
        self.personName = personName
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
