//
//  DiningTableExamples.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 28/06/24.
//

import Foundation

extension DiningTable {
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
    static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
    static let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!
    
    static var samplesDiningTable: [DiningTable] {
        [
            DiningTable(title: "Aquele lá", color: "abd2cf", tip: 0.1, coverTip: 9.9),
            DiningTable(title: "Outback", color: "0000FF", dateAdded: yesterday),
            DiningTable(title: "Coco Bambu", color: "00FF00", dateAdded: lastWeek, raiting: 5),
            DiningTable(title: "Bar do jão", color: "FF0000", dateAdded: lastMonth)
        ]
    }
}
