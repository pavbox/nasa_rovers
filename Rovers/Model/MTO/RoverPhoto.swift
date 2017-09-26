//
//  RoverPhoto.swift
//  Rovers
//
//  Created by Admin on 26/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

class RoverPhoto: NSObject {
    // MARK: - Gallery struct
    
    public struct Cam: Decodable {
        var name: String?
        var full_name: String?
        
        var asDictionary: [String: String?] {
            return [
                "name": self.name,
                "full_name": self.full_name
            ]
        }
    }
    
    public struct Pictures: Decodable {
        var id         : Int?
        var sol        : Int?
        var camera     : Cam
        var img_src    : String?
        var earth_date : String?
        
        var asDictionary: roverItem {
            return [
                "id"         : self.id,
                "sol"        : self.sol,
                "camera"     : self.camera.asDictionary,
                "img_src"    : self.img_src,
                "earth_date" : self.earth_date
            ]
        }
    }
    
    
    public struct RoverPhotoJSON: Decodable {
        var photos: [Pictures]
        
        var asDictionary: roverDictionary {
            var pics: roverDictionary = []
            
            for pic in photos {
                pics.append(pic.asDictionary)
            }
            return pics
        }
    }
}
