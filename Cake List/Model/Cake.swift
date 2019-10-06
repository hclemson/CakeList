//
//  Cake.swift
//  Cake List
//
//  Created by Helen Clemson on 06/10/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

@objc class Cake: NSObject {
    var _title: String!
    var _desc: String!
    var _image: String!
    
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
