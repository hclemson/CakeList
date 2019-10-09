//
//  Cake.swift
//  Cake List
//
//  Created by Helen Clemson on 06/10/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

// Using class instead of structs (and Codeable) so that 'Cake' can be exposed in obj-c
@objc class Cake: NSObject {
    var _title: String!
    var _desc: String!
    var _image: String!
    
    init?(json: [String: Any]) {
         guard let title = json["title"] as? String,
             let desc = json["desc"] as? String,
             let image = json["image"] as? String
         else {
             return nil
         }

         super.init()
         self.title = title
         self.desc = desc
         self.image = image
     }
    
    @objc var title:String {
        get {
            return _title
        }
        set (newVal) {
            if newVal.count > 0 {
                _title = newVal
            }
        }
    }
    
    @objc var desc:String {
        get {
            return _desc
        }
        set (newVal) {
            if newVal.count > 0 {
                _desc = newVal
            } else {
                _desc = "No description"
            }
        }
    }
    
    @objc var image:String {
        get {
            return _image
        }
        set (newVal) {
            if newVal.count > 0 {
                _image = newVal
            }
        }
    }
}
