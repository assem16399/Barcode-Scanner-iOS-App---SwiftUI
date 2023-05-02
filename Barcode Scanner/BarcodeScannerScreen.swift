//
//  ContentView.swift
//  Barcode Scanner
//
//  Created by Aasem Hany on 02/05/2023.
//

import SwiftUI

struct BarcodeScannerScreen: View {
    
    @State private var barcode = ""
    var body: some View {
        
        NavigationView {
            VStack {
                Spacer()
                ScannerView(barcode:$barcode)
                    .frame(maxWidth:.infinity,maxHeight:300)
                .padding(.bottom,30.0)

                Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)
                    .padding(10.0)
                Text(barcode.isEmpty ? "Not Yet Scanned" : barcode)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(barcode.isEmpty ? .red : .green)
                Spacer()

            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerScreen()
    }
}
