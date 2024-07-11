//
//  ItemInTable.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 04/07/24.
//

import Foundation

extension DiningItem {
    static var sampleDinningItem: [DiningItem] = [
        DiningItem(itemName: "Coca Cola lata", itemPrice: 9.90, itemType: DiningItemType.drink.rawValue),
        DiningItem(itemName: "Petit gateu", itemPrice: 35.50, itemType: DiningItemType.dessert.rawValue),
        DiningItem(itemName: "Macarrão com camarão", itemPrice: 149.90, itemType: DiningItemType.mainCourse.rawValue),
        DiningItem(itemName: "Drink com vodka", itemPrice: 16.90, itemType: DiningItemType.drink.rawValue)
    ]
}
