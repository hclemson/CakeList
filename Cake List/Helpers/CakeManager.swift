//
//  CakeManager.swift
//  Cake List
//
//  Download and parsing of cakes
//
//  Created by Helen Clemson on 06/10/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import Foundation

@objc class CakeManager: NSObject {
    
    /**
    Downloads a list of cakes

    - Parameter completion: Completion block when cakes have downloaded
    */
    @objc public func downloadCakes(completion: @escaping (Array<Cake>?, Error?) -> Void) {
        
        // Setup request
        var request = URLRequest(url: Config.cakeURL as URL)
        request.httpMethod = "GET"
        
        // HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Make the request
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            
            do {
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else {
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                
                // Convert the raw data to cakes
                let cakes = self.parseJsonCakes(data: json)
                completion(cakes, nil)
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
        
        task.resume()
    }
    
    /**
    Parses an array of cake data

    - Parameter data: [String:Any] array of cakes

    - Returns: Array of `Cake`s
    */
    private func parseJsonCakes(data: [[String: Any]]) -> Array<Cake> {
        var cakes = Array<Cake>()
        for cake in data {
            let title = cake["title"] as? String ?? "Unknown"
            let desc = cake["desc"] as? String ?? "Unknown"
            let image = cake["image"] as? String ?? "Unknown"
            
            let cake: Cake = Cake()
            cake.title = title
            cake.desc = desc
            cake.image = image
            
            cakes.append(cake)
        }
        return cakes
    }
}
