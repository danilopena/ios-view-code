//
//  String+Extension.swift
//  ios-view-code
//
//  Created by Danilo Pena on 30/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
