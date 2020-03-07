//
//  MyUser.swift
//  BikeApplication
//
//  Created by Sam Perry on 07/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import Foundation

struct MyUser: Decodable{
    let firstName:String
    let lastName:String
    let email:String
    let uid:String
}