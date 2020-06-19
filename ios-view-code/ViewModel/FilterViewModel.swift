//
//  FilterViewModel.swift
//  ios-view-code
//
//  Created by Danilo Pena on 30/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class FilterViewModel {
    private let networkLayer: NetworkLayer
    private weak var delegate: PatternViewModelDelegate?

    init(delegate: PatternViewModelDelegate, networkLayer: NetworkLayer = NetworkLayer()) {
        self.delegate = delegate
        self.networkLayer = networkLayer
    }
}

extension FilterViewModel {
    private enum Localizable {
        static let filter = "FILTER"
        static let clear = "CLEAR"
        static let apply = "APPLY"
        static let name = "NAME"
        static let giveName = "GIVE_NAME"
        static let species = "SPECIES"
        static let selectOne = "SELEC_ONE"
    }
    
    static let filterCellIdenfier = "filterCell"
    
    var filterString: String {
        return Localizable.filter.localized
    }
    
    var clearString: String {
        return Localizable.clear.localized
    }
    
    var applyString: String {
        return Localizable.apply.localized
    }
    
    var nameString: String {
        return Localizable.name.localized
    }
    
    var giveNameString: String {
        return Localizable.giveName.localized
    }
    
    var speciesString: String {
        return Localizable.species.localized
    }
    
    var selectOneString: String {
        return Localizable.selectOne.localized
    }
}
