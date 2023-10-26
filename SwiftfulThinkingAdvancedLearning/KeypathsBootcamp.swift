//
//  KeypathsBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 9/28/23.
//

import SwiftUI

struct MyDataModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let count: Int
    let date: Date
}

struct MovieTitle {
    let primary: String
    let secondary: String
}

extension Array {
    
    mutating func sortByKeyPath<T:Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) {
        self.sort { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            return ascending ? (value1 < value2) : (value1 > value2)
        }
    }
    
    func sortedByKeyPath<T:Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self.sorted { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            return ascending ? (value1 < value2) : (value1 > value2)
        }
    }
}

struct KeypathsBootcamp: View {
    
    @Environment(\.dismiss) var dismiss
    @AppStorage("user_count") var userCount: Int = 0

    @State private var dataArray: [MyDataModel] = []
    
    var body: some View {
        List {
            ForEach(dataArray) { item in
                VStack(alignment: .leading) {
                    Text(item.id)
                    Text(item.title)
                    Text("\(item.count)")
                    Text(item.date.description)
                }
                .font(.headline)
            }
        }
            .onAppear {
                var array = [
                    MyDataModel(title: "Three", count: 3, date: .distantFuture),
                    MyDataModel(title: "One", count: 1, date: .now),
                    MyDataModel(title: "Two", count: 2, date: .distantPast),
                ]
                
//                let newArray = array.sorted { item1, item2 in
//                    return item1.count < item2.count
//                }
                
//                let newArray = array.sorted { item1, item2 in
//                    return item1[keyPath: \.count] < item2[keyPath: \.count]
//                }
                
//                let newArray = array.customSorted()
                
//                let newArray = array.sortedByKeyPath(\.date, ascending: true)
                
                array.sortByKeyPath(\.count)
                
                dataArray = array
                
                
                
//                let title = item.title
//                let title2 = item[keyPath: \.title]
//                screenTitle = title2
                
                
            }
    }
}

#Preview {
    KeypathsBootcamp()
}
