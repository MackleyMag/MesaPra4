//
//  DiningItem.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 02/07/24.
//

import SwiftData
import SwiftUI

@Model
class DiningItem {
    var itemName: String
    var itemPrice: Decimal
    var itemType: DiningItemType.RawValue
    
    var diningTable: DiningTable?
    
    @Relationship var people: [PersonInTable]?
    
    init(itemName: String, itemPrice: Decimal, itemType: DiningItemType.RawValue) {
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemType = itemType
    }
}

enum DiningItemType: Int, Codable, Identifiable, CaseIterable {
    case drink, mainCourse, snack, appetizer, dessert
    
    var id: Self {
        self
    }
    
    var descr: LocalizedStringResource {
        switch self {
        case .drink:
            "Bebida"
        case .mainCourse:
            "Prato principal"
        case .snack:
            "Petisco"
        case .appetizer:
            "Entrada"
        case .dessert:
            "Sobremesa"
        }
    }
    
    var icon: String {
        switch self {
        case .drink:
            "mug"
        case .mainCourse:
            "fork.knife.circle"
        case .snack:
            "carrot.fill"
        case .appetizer:
            "cup.and.saucer.fill"
        case .dessert:
            "birthday.cake"
        }
    }
}
