//
//  Rover.swift
//  Rovers
//
//  Created by Admin on 25/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import Foundation
import UIKit

typealias roverDictionary = [[String: Any?]]
typealias roverItem  = [String: Any?]

class Rover: NSObject {
    private let API_ROVER = "https://api.nasa.gov/mars-photos/api/v1"
    private let API_KEY = "v1DSVRALYpyFo45dmNAasFbDYg4bszNEAmD35DQU"
    
    
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
    
    public func getRoverManifest(rover: String, _ callback: @escaping ( roverItem ) -> Void ) {
        guard let url = URL(string: "\(self.API_ROVER)/manifests/\(rover)/?api_key=\(self.API_KEY)") else { return }

        var manifest: ManifestJSON?
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    manifest = try JSONDecoder().decode(ManifestJSON.self, from: data)
                    DispatchQueue.main.async() { () -> Void in
                        callback((manifest?.asDictionary)!)
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    
    
    
    // MARK: - Gallery struct
    
    private struct Cam: Decodable {
        var name: String?
        var full_name: String?
        
        var asDictionary: [String: String?] {
            return [
                "name": self.name,
                "full_name": self.full_name
            ]
        }
    }
    
    private struct Pictures: Decodable {
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
    
    
    private struct RoverPhotoJSON: Decodable {
        var photos: [Pictures]
        
        var asDictionary: roverDictionary {
            var pics: roverDictionary = []
            
            for pic in photos {
                pics.append(pic.asDictionary)
            }
            return pics
        }
    }
    
    
    public func getRoverPhoto(rover: String, sol: String, cam: String, _ callback: @escaping ( roverItem ) -> Void ) {
        guard let url = URL(string: "\(self.API_ROVER)/rovers/\(rover)/photos?sol=\(sol)&page=1&camera=\(cam)&api_key=\(self.API_KEY)") else { return }
        
        var roverPhoto: RoverPhotoJSON?
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    roverPhoto = try JSONDecoder().decode(RoverPhotoJSON.self, from: data)
                    DispatchQueue.main.async() { () -> Void in
                        // get only first photo entity
                        if (roverPhoto?.asDictionary)!.count > 0 {
                            callback((roverPhoto?.asDictionary)![0])
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    
    public func loadFromUrl(_ imageUrl: URL?, _ callback: @escaping (UIImage) -> Void) {
        if let url = imageUrl {
            DispatchQueue.global(qos: .userInitiated).async {
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = contentsOfURL {
                        callback(UIImage(data: imageData)!)
                    }
                }
            }
        }
    }

    
    
    public func getRoverList(_ callback: @escaping ( roverDictionary ) -> Void ) {
        guard let url = URL(string: "\(self.API_ROVER)/rovers/?api_key=\(self.API_KEY)") else { return }
        
        /*
         FIXME: Cahce URL Does not working
        let session: NSURLSession = NSURLSession(configuration: self.configuration)
        let request = NSURLRequest(URL: self.url)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            // Handle image
        }
        
        dataTask.resume()
        session.finishTasksAndInvalidate()
        let URLCache = NSURLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        NSURLCache.setSharedURLCache(URLCache)
         */
        
        var roversJSON: RoversJSON?
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    roversJSON = try JSONDecoder().decode(RoversJSON.self, from: data)
                    DispatchQueue.main.async() { () -> Void in
                        callback((roversJSON?.asDictionary)!)
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
