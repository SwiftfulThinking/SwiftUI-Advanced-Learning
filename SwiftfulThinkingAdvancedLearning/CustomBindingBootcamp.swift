//
//  CustomBindingBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 9/26/23.
//

import SwiftUI

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}

struct CustomBindingBootcamp: View {
    
    @State var title: String = "Start"
    
    @State private var errorTitle: String? = nil
//    @State private var showError: Bool = false
    
    var body: some View {
        VStack {
            Text(title)
            
            ChildView(title: $title)
            
            ChildView2(title: title) { newTitle in
                title = newTitle
            }
            
            ChildView3(title: $title)
            
            ChildView3(title: Binding(get: {
                return title
            }, set: { newValue in
                title = newValue
            }))
            
//            Text(showError.description)
            
            Button("CLICK ME") {
                errorTitle = "NEW ERROR!!!!"
//                showError.toggle()
                
            }
        }
        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
            Button("OK") {
                
            }
        }
//        .alert(errorTitle ?? "Error", isPresented: Binding(get: {
//            errorTitle != nil
//        }, set: { newValue in
//            if !newValue {
//                errorTitle = nil
//            }
//        })) {
//            Button("OK") {
//                
//            }
//        }
//        .alert(errorTitle ?? "Error", isPresented: $showError) {
//            Button("OK") {
//                
//            }
//        }
    }
}

struct ChildView: View {
    
    @Binding var title: String
    
    var body: some View {
        Text(title)
            .onAppear {
//                title = "NEW TITLE"
            }
    }
}

struct ChildView2: View {
    
    let title: String
    let setTitle: (String) -> Void
    
    var body: some View {
        Text(title)
            .onAppear {
//                setTitle("NEW TITLE 2")
            }
    }
}

struct ChildView3: View {
    
    let title: Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
            .onAppear {
                title.wrappedValue = "NEW TITLE 3"
            }
    }
}

#Preview {
    CustomBindingBootcamp()
}
