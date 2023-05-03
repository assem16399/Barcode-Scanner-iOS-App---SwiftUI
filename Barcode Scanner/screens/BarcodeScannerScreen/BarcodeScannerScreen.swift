//
//  ContentView.swift
//  Barcode Scanner
//
//  Created by Aasem Hany on 02/05/2023.
//

import SwiftUI



struct BarcodeScannerScreen: View {
    
    @StateObject private var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        
        print("Called")
        return NavigationView {
            VStack {
                Spacer()
                ScannerView(barcode:$viewModel.scannedCode,alertItem:$viewModel.alertItem)
                    .frame(maxWidth:.infinity,maxHeight:300)
                .padding(.bottom,30.0)

                Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)
                    .padding(10.0)
                Text(viewModel.barcodeText)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(viewModel.barcodeTextColor)
                Spacer()

            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $viewModel.alertItem){alertItem in
                Alert(title: Text(alertItem.title),message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerScreen()
    }
}
