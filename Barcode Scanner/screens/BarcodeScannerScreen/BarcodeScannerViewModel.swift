//
//  BarcodeScannerViewModel.swift
//  Barcode Scanner
//
//  Created by Aasem Hany on 03/05/2023.
//

import SwiftUI


final class BarcodeScannerViewModel: ObservableObject{
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    
    var barcodeText:String {
        scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
    }
    var barcodeTextColor:Color {
        scannedCode.isEmpty ? .red : .green
    }
}
