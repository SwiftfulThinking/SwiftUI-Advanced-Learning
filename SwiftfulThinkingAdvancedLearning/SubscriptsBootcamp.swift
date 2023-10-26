//
//  SubscriptsBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 10/6/23.
//

import SwiftUI

struct MyTestStruct {
    let name: String
}

extension Array {
    
//    func getItem(atIndex: Int) -> Element? {
//        for (index, element) in self.enumerated() {
//            if index == atIndex {
//                return element
//            }
//        }
//        
//        return nil
//    }
    
//    subscript(atIndex: Double) -> Element? {
//        for (index, element) in self.enumerated() {
//            if Double(index) == atIndex {
//                return element
//            }
//        }
//        
//        return nil
//    }
}

extension Array where Element == String {
    
    subscript(value: String) -> Element? {
        self.first(where: { $0 == value })
    }
}

struct Address {
    let street: String
    let city: City
}

struct City {
    let name: String
    let state: String
}

struct Customer {
    let name: String
    let address: Address
    
    subscript(value: String) -> String {
        switch value {
        case "name":
            return name
        case "address":
            return "\(address.street), \(address.city.name)"
        case "city":
            return address.city.name
        default:
            fatalError()
        }
    }
    
    subscript(index: Int) -> String {
        switch index {
        case 0:
            return name
        case 1:
            return "\(address.street), \(address.city)"
        default:
            fatalError()
        }
    }
}

struct SubscriptsBootcamp: View {
    
    @State private var myArray: [String] = ["one", "two", "three"]
    @State private var selectedItem: String? = nil
    
    var body: some View {
        VStack {
            ForEach(myArray, id: \.self) { string in
                Text(string)
            }
            
            Text("SELECTED: \(selectedItem ?? "none")")
        }
        .onAppear {
            selectedItem = myArray[0]
            
//            selectedItem = myArray.first(where: { $0 == value })
            selectedItem = myArray["three"]
            
            let customer = Customer(
                name: "Nick",
                address: Address(
                    street: "Main Street",
                    city: City(name: "New York", state: "New York")
                )
            )
            
//            selectedItem = customer.name
//            selectedItem = customer[keyPath: \.name]
            selectedItem = customer["city"]
//            selectedItem = customer[0]
            
//            selectedItem = myArray[0.0]
        }
    }
}

#Preview {
    SubscriptsBootcamp()
}
