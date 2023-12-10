//
//  Cruise.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-12-05.
//

import Foundation

class Cruise{
    
    var id : String!
    var name : String!
    var imageName : String!
    var details : String!
    var ratings  : String!

    
    public init(id:String, name:String, imageName:String, details:String, ratings: String)
    {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.details = details
        self.ratings = ratings
    }
}
