//
//  RoversJSON.swift
//  Rovers
//
//  Created by Admin on 26/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

class Rovers: NSObject {
    // MARK: - rovers struct
    
    private struct Cameras: Decodable {
        var name: String?
        var fullname: String?
        
        var asDictionary: [String: String?] {
            return [
                "name": self.name,
                "fullname": self.fullname
            ]
        }
    }
    
    private struct Rovers: Decodable {
        var name          : String?
        var landing_date  : String?
        var launch_date   : String?
        var status        : String?
        var max_sol       : Int?
        var max_date      : String?
        var total_photos  : Int?
        var cameras       : [Cameras]
        
        var asDictionary: roverItem {
            var camera: roverDictionary = []
            
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
    
    
    private struct RoversJSON: Decodable {
        var rovers: [Rovers]
        
        var asDictionary: roverDictionary {
            var rov: roverDictionary = []
            
            for rover in rovers {
                rov.append(rover.asDictionary)
            }
            return rov
        }
    }
}
