//
//  PropertyWrapperBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 9/29/23.
//

import SwiftUI

extension FileManager {
    
    static func documentsPath(key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "\(key).txt")
    }
}

@propertyWrapper
struct FileManagerProperty: DynamicProperty {
    @State private var title: String
    let key: String
    
    var wrappedValue: String {
        get {
            title
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<String> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
        })
    }
    
    init(wrappedValue: String, _ key: String) {
        self.key = key
        
        do {
            title = try String(contentsOf: FileManager.documentsPath(key: key), encoding: .utf8)
            print("SUCCESS READ")
        } catch {
            title = wrappedValue
            print("ERROR READ: \(error)")
        }
    }
    
    func save(newValue: String) {
        do {
            // When atomically is set to true, it means that the data will be written to a temporary file first.
            // When atomically is set to false, the data is written directly to the specified file path.
            try newValue.write(to: FileManager.documentsPath(key: key), atomically: false, encoding: .utf8)
            title = newValue
//            print(NSHomeDirectory())
            print("SUCCESS SAVED")
        } catch {
            print("EEROR SAVING: \(error)")
        }
    }
}

struct PropertyWrapperBootcamp: View {
    
    @FileManagerProperty("custom_title_1") private var title: String = "Start text"
    @FileManagerProperty("custom_title_2") private var title2: String = "Starting text 2"
    @FileManagerProperty("custom_title_3") private var title3: String = "Starting text 3"
//    @AppStorage("title_key") private var title3: String = ""
//    var fileManagerProperty = FileManagerProperty()
    @State private var subtitle: String = "SUBTITLE"
    
    var body: some View {
        VStack(spacing: 40) {
            Text(title).font(.largeTitle)
            Text(title2).font(.largeTitle)
            Text(title3).font(.largeTitle)
            PropertyWrapperChildView(subtitle: $title)

            Button("Click me 1") {
                title = "title 1"
            }
            Button("Click me 2") {
                title = "title 2"
                title2 = "SOME RANDOM TITLE"
            }
        }
    }
}

struct PropertyWrapperChildView: View {
    
    @Binding var subtitle: String
    var body: some View {
        Button(action: {
            subtitle = "ANOTHER TITLE!!!!!!"
        }, label: {
            Text(subtitle).font(.largeTitle)
        })
    }
}

#Preview {
    PropertyWrapperBootcamp()
}
