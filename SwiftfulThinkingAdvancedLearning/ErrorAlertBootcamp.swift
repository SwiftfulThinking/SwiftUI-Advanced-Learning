//
//  ErrorAlertBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 9/26/23.
//

import SwiftUI

// Error
// Alert

protocol AppAlert {
    var title: String { get }
    var subtitle: String? { get }
    var buttons: AnyView { get }
}

extension View {
    
    func showCustomAlert<T: AppAlert>(alert: Binding<T?>) -> some View {
        self
            .alert(alert.wrappedValue?.title ?? "Error", isPresented: Binding(value: alert), actions: {
                alert.wrappedValue?.buttons
            }, message: {
                if let subtitle = alert.wrappedValue?.subtitle {
                    Text(subtitle)
                }
            })
    }
    
}

struct ErrorAlertBootcamp: View {
    
    @State private var alert: MyCustomAlert? = nil
    
    var body: some View {
        Button("CLICK ME") {
            saveData()
        }
        .showCustomAlert(alert: $alert)
//        .alert(alert?.title ?? "Error", isPresented: Binding(value: $alert), actions: {
//            alert?.getButtonsForAlert
//        }, message: {
//            if let subtitle = alert?.subtitle {
//                Text(subtitle)
//            }
//        })
    }
    
//    enum MyCustomError: Error, LocalizedError {
//        case noInternetConnection
//        case dataNotFound
//        case urlError(error: Error)
//        
//        var errorDescription: String? {
//            switch self {
//            case .noInternetConnection:
//                return "Please check your internet connection and try again."
//            case .dataNotFound:
//                return "There was an error loading data. Please try again!"
//            case .urlError(error: let error):
//                return "Error: \(error.localizedDescription)"
//            }
//        }
//    }
    
    enum MyCustomAlert: Error, LocalizedError, AppAlert {
        case noInternetConnection(onOkPressed: () -> Void, onRetryPressed: () -> Void)
        case dataNotFound
        case urlError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your internet connection and try again."
            case .dataNotFound:
                return "There was an error loading data. Please try again!"
            case .urlError(error: let error):
                return "Error: \(error.localizedDescription)"
            }
        }
        
        var title: String {
            switch self {
            case .noInternetConnection:
                return "No Internet Connection"
            case .dataNotFound:
                return "No Data"
            case .urlError:
                return "Error"
            }
        }
        
        var subtitle: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your internet connection and try again."
            case .dataNotFound:
                return nil
            case .urlError(error: let error):
                return "Error: \(error.localizedDescription)"
            }
        }
        
        var buttons: AnyView {
            AnyView(getButtonsForAlert)
        }
        
        @ViewBuilder var getButtonsForAlert: some View {
            switch self {
            case .noInternetConnection(onOkPressed: let onOkPressed, onRetryPressed: let onRetryPressed):
                Button("OK") {
                    onOkPressed()
                }
                Button("RETRY") {
                    onRetryPressed()
                }
            case .dataNotFound:
                Button("RETRY") {
                    
                }
            default:
                Button("Delete", role: .destructive) {
                    
                }
            }
        }
    }
    
    private func saveData() {
        let isSuccessful: Bool = false
        
        if isSuccessful {
            // do something
        } else {
            // Error
//            let myError: Error = URLError(.badURL)
//            let myError: Error = MyCustomAlert.urlError(error: URLError(.badURL))
//            errorTitle = "An error occured!"
            alert = .noInternetConnection(onOkPressed: {
                
            }, onRetryPressed: {
                
            })
        }
    }
}

#Preview {
    ErrorAlertBootcamp()
}
