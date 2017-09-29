//
//  RoverPhoto.swift
//  Rovers
//
//  Created by Admin on 26/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

class RoverPhotoJSON: NSObject, Decodable {

    private var photos: [Photo] = []
    
    public var asDictionary: [roverDictionary] {
        var pictures: [roverDictionary] = []
        
        for photo in photos {
            pictures.append(photo.asDictionary)
        }
        return pictures
    }
    
    
    private struct Photo: Decodable {
        var id         : Int
        var sol        : Int
        var camera     : Cam
        var img_src    : String
        var earth_date : String
        
        var asDictionary: roverDictionary {
            return [
                "id"         : self.id,
                "sol"        : self.sol,
                "camera"     : self.camera.asDictionary,
                "img_src"    : self.img_src,
                "earth_date" : self.earth_date
            ]
        }
    }
    
    
    private struct Cam: Decodable {
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
