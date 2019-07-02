//
//  ScannerViewFactory.swift
//  LeadLinkApp
//
//  Created by Marko Dimitrijevic on 02/07/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class ScannerViewFactory {
    
    func createCameraView(inScannerView scannerView: UIView, handler: @escaping () -> ()) -> QRcodeView {
        
        var loadedScannerView = scannerView
        
        let frame = QRcodeView.getRectForQrCodeView(center: loadedScannerView.center)
        
        let qrCodeView = QRcodeView.init(frame: frame, btnTapHandler: handler)
        
        loadedScannerView = qrCodeView
        loadedScannerView.isHidden = true
        
        return qrCodeView
        
    }
    
}

class MovingKeyboardDelegateFactory {
    
    func create(handler: @escaping (_ verticalShift: CGFloat) -> ()) -> MovingKeyboardDelegate {
        
        return MovingKeyboardDelegate.init(keyboardChangeHandler: { (halfKeyboardHeight) in
            var verticalShift: CGFloat = 0
            if UIDevice.current.userInterfaceIdiom == .phone {
                verticalShift = 2*halfKeyboardHeight
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                verticalShift = halfKeyboardHeight
            }
            handler(verticalShift)
        })
    }
}
