//
//  CharacterRickAndMorty.swift
//  ios-swiftui-project
//
//  Created by Danilo Pena on 27/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class StandardNameAndUrl: Codable {
    var name: String?
    var url: String?
}

class WrapperCharacters: Codable {
    var info: PageInfo?
    var results: [CharacterRickAndMorty]?
}

class CharacterRickAndMorty: Codable {
    var id: Int!
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: StandardNameAndUrl?
    var location: StandardNameAndUrl?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
}
