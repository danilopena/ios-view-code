//
//  CharacterViewModel.swift
//  ios-swiftui-project
//
//  Created by Danilo Pena on 27/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit



protocol PatternViewModelDelegate: class {
    func loaded(state: State)
}

class CharacterViewModel {
    private let networkLayer: NetworkLayer
    private(set) var chars: [CharacterRickAndMorty]?
    private(set) var singleDetailedChar: CharacterRickAndMorty?
    private weak var delegate: PatternViewModelDelegate?

    init(delegate: PatternViewModelDelegate, networkLayer: NetworkLayer = NetworkLayer()) {
        self.delegate = delegate
        self.networkLayer = networkLayer
    }
    
    func getCharacters(id: String? = "") {
        let successHandler: (WrapperCharacters) -> Void = { (wrapper) in
            if let chars = wrapper.results {
                self.chars = chars
                self.delegate?.loaded(state: .success)
            }
        }
        let errorHandler: (String) -> Void = { (error) in
            self.delegate?.loaded(state: .failed(error: error))
        }

        networkLayer.get(urlString: NetworkLayer.Constants.baseUrl + "character/",
                         successHandler: successHandler,
                         errorHandler: errorHandler)
    }
    
    func getCharOfIndex(index: Int) -> CharacterRickAndMorty? {
        return chars?[index]
    }
}
