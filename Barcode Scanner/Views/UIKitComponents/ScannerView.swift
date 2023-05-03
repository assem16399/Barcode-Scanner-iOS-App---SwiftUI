//
//  ScannerView.swift
//  Barcode Scanner
//
//  Created by Aasem Hany on 02/05/2023.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var barcode:String
    @Binding var alertItem:AlertItem?
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
        
    final class Coordinator:NSObject,ScannerVCDelegate{
        
        let scannerView:ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFind(barcode: String) {
            print(barcode)
            self.scannerView.barcode = barcode
        }
        
        func didSurface(error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                self.scannerView.alertItem = AlertContext.invalidDeviceInput
            case .invalidScannedValue:
                self.scannerView.alertItem = AlertContext.invalidScannedInput
            
            }
            
        }
    }
}


