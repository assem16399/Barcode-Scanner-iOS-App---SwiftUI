//
//  Alert.swift
//  Barcode Scanner
//
//  Created by Aasem Hany on 03/05/2023.
//

import SwiftUI
struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}


struct AlertContext {
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input!", message: "Something worng with the camera. We're not able to capture input.", dismissButton: .default(Text("OK")))
    
    static let invalidScannedInput = AlertItem(title: "Invalid Scanned Input!", message: "The value scanned is invalid. This app scans EAN-8 &  EAN-13.", dismissButton: .default(Text("OK")))
}
