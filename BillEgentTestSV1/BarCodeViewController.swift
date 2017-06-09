//
//  ViewController.swift
//  BillEgentTestSV1
//
//  Created by kuan-yu Chiang on 07/06/2017.
//  Copyright © 2017 kuan-yu Chiang. All rights reserved.
//

import UIKit
import CoreImage
import RSBarcodes_Swift
import AVFoundation

class BarCodeViewController: UIViewController {
    
    var barcodeArray = [String:Any]()
    
    @IBOutlet weak var code1Img: UIImageView!
    @IBOutlet weak var code2Img: UIImageView!
    @IBOutlet weak var code3Img: UIImageView!
    
    @IBOutlet weak var code1Label: UILabel!
    @IBOutlet weak var code2Label: UILabel!
    @IBOutlet weak var code3Label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showImag()
        
    }
    
    func showImag() {
        
        if barcodeArray.isEmpty == false {
            
            code1Img.image = RSUnifiedCodeGenerator.shared.generateCode((barcodeArray["code1"] as! String), machineReadableCodeObjectType: AVMetadataObjectTypeCode39Code)
            code1Label.text = barcodeArray["code1"] as? String
            
            code2Img.image = RSUnifiedCodeGenerator.shared.generateCode((barcodeArray["code2"] as! String), machineReadableCodeObjectType: AVMetadataObjectTypeCode39Code)
            code2Label.text = barcodeArray["code2"] as? String

            
            code3Img.image = RSUnifiedCodeGenerator.shared.generateCode((barcodeArray["code3"] as! String), machineReadableCodeObjectType: AVMetadataObjectTypeCode39Code)
            code3Label.text = barcodeArray["code3"] as? String

            // print(barcodeArray)
            
        }
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

