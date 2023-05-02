//
//  ScannerVC.swift
//  Barcode Scanner
//
//  Created by Aasem Hany on 02/05/2023.
//

import UIKit
import AVFoundation

enum CameraError: String {
    case invalidDeviceInput = "Something worng with the camera. We're not able to capture input."
    case invalidScannedValue = "The value scanned is invalid. This app scans EAN-8 &  EAN-13."
}

protocol ScannerVCDelegate:AnyObject {
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}

final class ScannerVC: UIViewController {

    // The Camera Capturing Session
    let captureSession = AVCaptureSession()
    // Preview while you are moving camera until you caputure
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    // The Delegate of the ScannerVC that will notify when the barcode gets found
    weak var scannerDelegate: ScannerVCDelegate!
    
    init(scannerDelegate: ScannerVCDelegate!) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer else {
            scannerDelegate.didSurface(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }

    // Basic setup to get our camera up and running, looking for barcode and running previewLayer (Heart of this ViewController)
    private func setupCaptureSession(){
        // making sure that we a device that can capture video
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else{
            scannerDelegate.didSurface(error: .invalidDeviceInput)
            return
            
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do{
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        }
        catch{
            scannerDelegate.didSurface(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }else{
            scannerDelegate.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let metaDataoutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataoutput) {
            captureSession.addOutput(metaDataoutput)
            metaDataoutput.setMetadataObjectsDelegate(self, queue: .main)
            metaDataoutput.metadataObjectTypes = [.ean8, .ean13]
        }else{
            scannerDelegate.didSurface(error: .invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        DispatchQueue.global(qos: .default).async {[weak self] in
            self?.captureSession.startRunning()
        }
    }

}

extension ScannerVC:AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate.didSurface(error: .invalidScannedValue)
            return
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject  else {
            scannerDelegate.didSurface(error: .invalidScannedValue)
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate.didSurface(error: .invalidScannedValue)
            return
        }
        
        scannerDelegate.didFind(barcode: barcode)
    }
}
