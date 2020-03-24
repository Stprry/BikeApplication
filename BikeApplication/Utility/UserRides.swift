//
//  UserRides.swift
//  BikeApplication
//
//  Created by Sam Perry on 21/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import Foundation
import Foundation

struct UserRides: Decodable{
    let rideDate : String
    let rideLeader : String
    let rideLeaderUID : String
    let rideLocation : String
    let rideName : String
    let rideType: String
    let rideXCordinate : Double
    let rideYCordinate : Double
}

