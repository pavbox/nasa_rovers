//
//  Manifest.swift
//  Rovers
//
//  Created by Admin on 26/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

class Manifest: NSObject {
    // MARK: - manifesto struct
    
    private struct Photos: Decodable {
        var sol          : Int
        var total_photos : Int
        var cameras      : [String]
        
        var asDictionary: [String: Any] {
            
            return [
                "sol"         : self.sol,
                "total_photos": self.total_photos,
                "cameras"     : self.cameras
            ]
        }
    }
    
    
    private struct PhotoManifest: Decodable {
        var name          : String?
        var landing_date  : String?
        var launch_date   : String?
        var status        : String?
        var max_sol       : Int?
        var max_date      : String?
        var total_photos  : Int?
        var photos        : [Photos]
        
        var asDictionary: roverItem {
            var photo: roverDictionary = []
            
            for picture in photos {
                photo.append(picture.asDictionary)
            }
            
            return [
                "name"         : self.name,
                "landing_date" : self.landing_date,
                "launch_date"  : self.launch_date,
                "status"       : self.status,
                "max_sol"      : self.max_sol,
                "max_date"     : self.max_date,
                "total_photos" : self.total_photos,
                "photos"       : photo
            ]
        }
    }
    
    
    private struct ManifestJSON: Decodable {
        var photo_manifest: PhotoManifest
        
        var asDictionary: roverItem {
            return [
                "photo_manifest": self.photo_manifest.asDictionary
            ]
        }
    }
}
