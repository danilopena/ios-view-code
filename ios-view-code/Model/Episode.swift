//
//  Episode.swift
//  ios-view-code
//
//  Created by Danilo Pena on 29/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class Episode: Codable {
    var id: Int?
    var name: String?
    var air_date: String?
    var episode: String?
    var characters: [String]?
    var url: String?
    var created: String?
}
