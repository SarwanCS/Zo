//
//  Sniptest.swift
//  Zo
//
//  Created by Brian Heralall on 4/21/22.
//


// The components of what makes up the shortcut type that the user is going to be creating. 

import Foundation

struct Sniptest: Hashable, Codable {
    var name: String
    var content: String
    var color: String
    var image: String
    var pickedimage: Data
}
