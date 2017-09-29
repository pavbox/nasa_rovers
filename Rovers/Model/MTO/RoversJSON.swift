//
//  RoversJSON.swift
//  Rovers
//
//  Created by Admin on 26/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

class RoversJSON: NSObject, Decodable {

    private var rovers: [Rovers] = []
        
    public var asDictionary: [roverDictionary] {
        var rovs: [roverDictionary] = []
            
        for rover in rovers {
            rovs.append(rover.asDictionary)
        }
        return rovs
    }
    
    
    private struct Rovers: Decodable {
        var name          : String
        var landing_date  : String
        var launch_date   : String
        var status        : String
        var max_sol       : Int
        var max_date      : String
        var total_photos  : Int
        var cameras       : [Cameras]
        
        var asDictionary: roverDictionary {
            var camera: [roverDictionary] = []
            
            for cam in cameras {
                camera.append(cam.asDictionary)
            }
            
            return [
                "name"         : self.name,
                "landing_date" : self.landing_date,
                "launch_date"  : self.launch_date,
                "status"       : self.status,
                "max_sol"      : self.max_sol,
                "max_date"     : self.max_date,
                "total_photos" : self.total_photos,
                "cameras"      : camera
            ]
        }
    }
    
    private struct Cameras: Decodable {
        var name: String
        var full_name: String
        
        var asDictionary: [String: String] {
            return [
                "name": self.name,
                "full_name": self.full_name
            ]
        }
    }
    
    
    
}
