//
//  Rover.swift
//  Rovers
//
//  Created by Admin on 25/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import Foundation
import UIKit

typealias roverDictionary  = [String: Any]

class RoverData: NSObject {
    private let API_ROVER = "https://api.nasa.gov/mars-photos/api/v1"
    private let API_KEY = "v1DSVRALYpyFo45dmNAasFbDYg4bszNEAmD35DQU"

    
    public func getRoverManifest(rover: String, _ callback: @escaping ( roverDictionary, String, [String] ) -> Void ) {
        guard let url = URL(string: "\(self.API_ROVER)/manifests/\(rover)/?api_key=\(self.API_KEY)") else { return }
        
        let cachableRequest = createCachableLink(url: url)
        
        URLSession.shared.dataTask(with: cachableRequest) { (data, response, error) in
            if let data = data {
                do {
                    let manifest = try JSONDecoder().decode(ManifestJSON.self, from: data)
                    
                    let manifesto = manifest.asDictionary
                    
                    let photo_manifest = manifesto["photo_manifest"] as! roverDictionary
                    let title  = photo_manifest["name"] as! String
                    let photos = photo_manifest["photos"] as! [roverDictionary]
                    
                    var dataSolCollection: [String] = []
                   
                    for photo in photos {
                        dataSolCollection.append(String(describing: photo["sol"]!))
                    }
                    
                    
                    DispatchQueue.main.async() { () -> Void in
                        callback(photo_manifest, title, dataSolCollection)
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    
    
    public func getRoverPhoto(rover: String, sol: String, cam: String, _ callback: @escaping ( roverDictionary ) -> Void ) {
        guard let url = URL(string: "\(self.API_ROVER)/rovers/\(rover)/photos?sol=\(sol)&page=1&camera=\(cam)&api_key=\(self.API_KEY)") else { return }
        
        let cachableRequest = createCachableLink(url: url)
        
        URLSession.shared.dataTask(with: cachableRequest) { (data, response, error) in
            if let data = data {
                do {
                    let roverPhoto = try JSONDecoder().decode(RoverPhotoJSON.self, from: data)
                    DispatchQueue.main.async() { () -> Void in
                        // get only first photo entity
                        if roverPhoto.asDictionary.count > 0 {
                            callback(roverPhoto.asDictionary[0])
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    
    public func downloadImageFromURL(_ imageUrl: URL?, _ callback: @escaping (UIImage) -> Void) {
        if let url = imageUrl {
            let cachableRequest = createCachableLink(url: url)
            URLSession.shared.dataTask(with: cachableRequest) { (data, response, error) in
                if let data = data {
                    let uiImage = UIImage(data: data)!;
                    DispatchQueue.main.async() { () -> Void in
                        callback(uiImage)
                    }
                }
            }.resume()
        }
    }
    
    
    

    public func getRoverList(_ callback: @escaping ( [roverDictionary] ) -> Void ) {
        guard let url = URL(string: "\(self.API_ROVER)/rovers/?api_key=\(self.API_KEY)") else { return }
        
        let cachableRequest = createCachableLink(url: url)

        URLSession.shared.dataTask(with: cachableRequest) { (data, response, error) in
            if let data = data {
                do {
                    let rovers = try JSONDecoder().decode(RoversJSON.self, from: data)
                    DispatchQueue.main.async() { () -> Void in
                        callback(rovers.asDictionary)
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    
    private func createCachableLink(url: URL) -> URLRequest {
        return URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10000)
    }
}
