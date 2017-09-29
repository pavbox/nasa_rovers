//
//  RoverDetailViewController.swift
//  Rovers
//
//  Created by Admin on 26/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

class RoverDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let roverData = RoverData()
    
    var manifest: roverDictionary?
    var segueRover: roverDictionary?
   
    var pickerDataSol:[String] = [String]()
    var pickerDataCam:[String] = [String]()
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var solPickerField: UITextField!
    @IBOutlet weak var camPickerField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainText: UITextView!
    
    
    @IBAction func searchRoverData(_ sender: UIButton) {
        if (solPickerField.text!.isEmpty == false && camPickerField.text!.isEmpty == false) {
            // hide picker by event emitter
            self.view.endEditing(true)
            
            roverData.getRoverPhoto(rover: (segueRover!["name"])! as! String, sol: solPickerField.text!, cam: camPickerField.text!)
            {
                (roverPhoto) in
                
                let url = URL(string: roverPhoto["img_src"]! as! String)
                
                self.roverData.downloadImageFromURL(url) { (image) in
                    self.mainImage.image = image
                }
                
                
                let camera    = roverPhoto["camera"]! as! roverDictionary
                
                let fullname  = camera["full_name"]!  as! String
                let camname   = camera["name"]!  as! String
                
                let sol       = String(roverPhoto["sol"]! as! Int)
                let earthdate = roverPhoto["earth_date"]! as! String
                
            
                self.mainText.text = """
                Earth Date: \(earthdate)
                Martian Sol: \(sol)
                Camera: \(fullname) (\(camname))
                """
            }
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return pickerDataSol.count
        }
        
        if pickerView.tag == 2 {
            return pickerDataCam.count
        }
        return 0;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return pickerDataSol[row]
        }
        
        if pickerView.tag == 2 {
            return pickerDataCam[row]
        }
        
        return nil;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            solPickerField.text = pickerDataSol[row];
            
            let photos = self.manifest!["photos"] as! [roverDictionary]
            
            // fill second picker (cameras) after select first
            for pic in photos {
                if (pickerDataSol[row] == String(describing: pic["sol"]!)) {
                    self.pickerDataCam = pic["cameras"]! as! [String]
                }
            }
        }
        
        if pickerView.tag == 2 {
            print(pickerDataCam[row])
            camPickerField.text = pickerDataCam[row]
        }
    }


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if segueRover == nil { return }
        
        let solPickerView = UIPickerView()
        solPickerView.delegate = self
        solPickerView.tag = 1
        solPickerField.inputView = solPickerView
        
        
        let camPickerView = UIPickerView()
        camPickerView.delegate = self
        camPickerView.tag = 2
        camPickerField.inputView = camPickerView

        
        roverData.getRoverManifest(rover: (segueRover!["name"])! as! String) { (manifest, title, dataSolCollection) in
            self.manifest = manifest
            self.title = title
            self.pickerDataSol = dataSolCollection
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
