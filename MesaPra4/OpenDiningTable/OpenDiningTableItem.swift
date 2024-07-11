//
//  OpenDiningTableItem.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 04/07/24.
//

import SwiftUI

struct OpenDiningTableListItem: View {
    @State var dItem: DiningItem
    var body: some View {
        HStack(alignment: .center) {
            Circle()
                .foregroundStyle(Color.blue.opacity(0.3))
                .frame(width: 70)
                .overlay {
                    Image(systemName: getIcon(dItem.itemType))
                        .font(.system(size: 40))
                }
            VStack(alignment: .leading) {
                Text(dItem.itemName)
                    .font(.headline)
                if let people = dItem.people, !people.isEmpty{
                    Text("\(people.count) Pessoas dividindo")
                        .font(.subheadline)
                    HStack {
                        ForEach(people) { person in
                            Text(person.personName)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(person.hexColor.opacity(0.3))
                                        .padding(-2)
                                )
                        }
                    }
                    .font(.footnote)
                }
            }
            
            Spacer()
            HStack(alignment: .center) {
                Text(dItem.itemPrice.formatted(.currency(code: Locale.current.currency?.identifier ?? "BRL")))
            }
        }
    }
    func getIcon(_ itemType: DiningItemType.RawValue) -> String {
        if itemType == DiningItemType.drink.rawValue {
            return "mug"
        }
        if itemType == DiningItemType.mainCourse.rawValue {
            return "fork.knife.circle"
        }
        if itemType == DiningItemType.snack.rawValue {
            return "carrot.fill"
        }
        if itemType == DiningItemType.appetizer.rawValue {
            return "cup.and.saucer.fill"
        }
        if itemType == DiningItemType.dessert.rawValue {
            return "birthday.cake"
        }
        return "book"
    }
}

#Preview {
    let preview = PreviewContainer(DiningItem.self)
    let diningItem = DiningItem.sampleDinningItem
    preview.addExamples(diningItem)
    
    return OpenDiningTableListItem(dItem: diningItem[0])
        .modelContainer(preview.container)
}
