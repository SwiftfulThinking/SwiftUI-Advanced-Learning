//
//  AdvancedCombineBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 10/23/21.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
    //@Published var basicPublisher: String = "first publish"
    //let currentValuePublisher = CurrentValueSubject<Int, Error>("first publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passThroughPublisher.send(items[x])
                
                if (x > 4 && x < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }

                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            self.passThroughPublisher.send(1)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.passThroughPublisher.send(2)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.passThroughPublisher.send(3)
//        }
        
    }
    
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []
    @Published var error: String = ""
    
    let dataService = AdvancedCombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    let multiCastPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        //dataService.passThroughPublisher
        
            // Sequence Operations
            /*
            //.first()
            //.first(where: { $0 > 4 })
            //.tryFirst(where: { int in
            //    if int == 3 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return int > 1
            //})
            //.last()
            //.last(where: { $0 < 4 })
            //.tryLast(where: { int in
            //    if int == 13 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return int > 1
            //})
            //.dropFirst()
            //.dropFirst(3)
            //.drop(while: { $0 < 5 })
            //.tryDrop(while: { int in
            //    if int == 15 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return int < 6
            //})
            //.prefix(4)
            //.prefix(while: { $0 < 5 })
            //.tryPrefix(while: )
            //.output(at: 5)
            //.output(in: 2..<4)
        */
        
            // Mathematic Operations
            /*
            //.max()
            //.max(by: { int1, int2 in
            //    return int1 < int2
            //})
            //.tryMax(by: )
            //.min()
            //.min(by: )
            //.tryMin(by: )
        */
        
            // Filter / Reducing Operations
            /*
            //.map({ String($0) })
            //.tryMap({ int in
            //    if int == 5 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return String(int)
            //})
            //.compactMap({ int in
            //    if int == 5 {
            //        return nil
            //    }
            //    return  "\(int)" // String(int)
            //})
            //.tryCompactMap()
            //.filter({ ($0 > 3) && ($0 < 7) })
            //.tryFilter()
            //.removeDuplicates()
            //.removeDuplicates(by: { int1, int2 in
            //    return int1 == int2
            //})
            //.tryRemoveDuplicates(by: )
            //.replaceNil(with: 5)
            //.replaceEmpty(with: [])
            //.replaceError(with: "DEFAULT VALUE")
            //.scan(0, { existingValue, newValue in
            //    return existingValue + newValue
            //})
            //.scan(0, { $0 + $1 })
            //.scan(0, +)
            //.tryScan(, )
            //.reduce(0, { existingValue, newValue in
            //    return existingValue + newValue
            //})
            //.reduce(0, +)
            //.collect()
            //.collect(3)
            //.allSatisfy({ $0 < 50 })
            //.tryAllSatisfy()
        */
        
            // Timing Operations
            /*
            //.debounce(for: 0.75, scheduler: DispatchQueue.main)
            //.delay(for: 2, scheduler: DispatchQueue.main)
            //.measureInterval(using: DispatchQueue.main)
            //.map({ stride in
            //    return "\(stride.timeInterval)"
            //})
            //.throttle(for: 5, scheduler: DispatchQueue.main, latest: true)
            //.retry(3)
            //.timeout(0.75, scheduler: DispatchQueue.main)
        */
        
            // Multiple Publishers / Subscribers
            /*
            //.combineLatest(dataService.boolPublisher, dataService.intPublisher)
            //.compactMap({ (int, bool) in
            //    if bool {
            //        return String(int)
            //    }
            //    return nil
            //})
            //.compactMap({ $1 ? String($0) : "n/a" })
            //.compactMap({ (int1, bool, int2) in
            //    if bool {
            //        return String(int1)
            //    }
            //    return "n/a"
            //})
            //.merge(with: dataService.intPublisher)
            //.zip(dataService.boolPublisher, dataService.intPublisher)
            //.map({ tuple in
            //    return String(tuple.0) + tuple.1.description + String(tuple.2)
            //})
            //.tryMap({ int in
            //    if int == 5 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return int
            //})
            //.catch({ error in
            //    return self.dataService.intPublisher
            //})
        */
        
        
        let sharedPublisher = dataService.passThroughPublisher
            //.dropFirst(3)
            .share()
            //.multicast {
            //    PassthroughSubject<Int, Error>()
            //}
            .multicast(subject: multiCastPublisher)
        
        sharedPublisher
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "ERROR: \(error)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)

        sharedPublisher
            .map({ $0 > 5 ? true : false })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "ERROR: \(error)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.dataBools.append(returnedValue)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sharedPublisher
                .connect()
                .store(in: &self.cancellables)
        }
    }
    
}

struct AdvancedCombineBootcamp: View {
    
    @StateObject private var vm = AdvancedCombineBootcampViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) {
                        Text($0)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
                VStack {
                    ForEach(vm.dataBools, id: \.self) {
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                }
            }
        }
    }
}

struct AdvancedCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineBootcamp()
    }
}
