//
//  CharacterDetailViewModel.swift
//  ios-view-code
//
//  Created by Danilo Pena on 29/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

protocol CharacterDetailViewModelDelegate: class {
    func loaded(state: State)
    func loadedEpisodes(state: State)
}

class CharacterDetailViewModel {
    private let networkLayer: NetworkLayer
    private weak var delegate: CharacterDetailViewModelDelegate?
    private(set) var char: CharacterRickAndMorty?
    var episodeList: [Episode] = []
    var informationsData = [(title: String, subTitle: String)]()

    init(delegate: CharacterDetailViewModelDelegate, networkLayer: NetworkLayer = NetworkLayer()) {
        self.delegate = delegate
        self.networkLayer = networkLayer
    }

    func getCharacter(id: String) {
        let successHandler: (CharacterRickAndMorty) -> Void = { (result) in
            self.char = result
            self.delegate?.loaded(state: .success)
        }
        let errorHandler: (String) -> Void = { (error) in
            self.delegate?.loaded(state: .failed(error: error))
        }

        networkLayer.get(urlString: NetworkLayer.Constants.baseUrl + "character/" + id,
                         successHandler: successHandler,
                         errorHandler: errorHandler)
    }
    
    func returnIdEpisodesOfChar() -> String {
        var string = ""
        char?.episode?.forEach({ (episode) in
            if let splited = episode.split(separator: "/").last {
                if episode != char?.episode?.last {
                    string += (splited + ",")
                } else {
                    string += splited
                }
            }
        })
        return string
    }
    
    func getEpisodes() {
        let successHandler: ([Episode]) -> Void = { (result) in
            self.episodeList = result
            self.delegate?.loadedEpisodes(state: .success)
        }
        let errorHandler: (String) -> Void = { (error) in
            self.delegate?.loadedEpisodes(state: .failed(error: error))
        }

        networkLayer.get(urlString: NetworkLayer.Constants.baseUrl + "episode/" + returnIdEpisodesOfChar(),
                         successHandler: successHandler,
                         errorHandler: errorHandler)
    }
    
    func arrangeInfoData() {
        informationsData = [(title: String, subTitle: String)]()
        if let charNotNull = char {
            informationsData.append((title: "Gender", subTitle: charNotNull.gender ?? ""))
            informationsData.append((title: "Origin", subTitle: charNotNull.origin?.name ?? ""))
            informationsData.append((title: "Type", subTitle: charNotNull.type ?? ""))
            informationsData.append((title: "Location", subTitle: charNotNull.location?.name ?? ""))
        }
    }
}
