//
//  SnapshotExtensions.swift
//  BikeApplication
//
//  Created by Sam Perry on 07/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import Foundation
import Firebase

extension QueryDocumentSnapshot{
    func decoded<T : Decodable>() throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(T.self, from: jsonData)
        return object
    }
        
    
}
