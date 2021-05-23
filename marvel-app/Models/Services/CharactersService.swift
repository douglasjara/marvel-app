//
//  CharactersService.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

import Foundation
import CryptoKit

class CharactersService
{
    private(set) var characterDataWrapper = CharacterDataWrapper()
    weak var delegate: CharactersServiceDelegate?    
    
    init()
    {
        debugPrint("Init: Getting data from API!")
        getCharactersFromAPI(limit: MarvelServiceSettings.defaultLimit, offset: MarvelServiceSettings.defaultOffset)
    }
    
    public func refreshData()
    {
        debugPrint("Refreshing data from API!")
        getCharactersFromAPI(limit: MarvelServiceSettings.defaultLimit, offset: MarvelServiceSettings.defaultOffset)
    }
    
    public func getData(limit: Int, offset: Int)
    {
        debugPrint("Getting data from API!")
        getCharactersFromAPI(limit: limit, offset: offset)
    }
    
    private func getCharactersFromAPI(limit: Int, offset: Int)
    {
        let service = APIManager(url: getMarvelUrl(limit: limit, offset: offset))
        service.get() { (characterDataWrapper: CharacterDataWrapper?) in
            if let characterDataWrapper = characterDataWrapper {
                self.characterDataWrapper = characterDataWrapper
                if (offset == MarvelServiceSettings.defaultOffset) {
                    self.delegate?.charactersServiceDelegateDidUpdate(self, append: false)
                } else {
                    self.delegate?.charactersServiceDelegateDidUpdate(self, append: true)
                }
            }
        }
    }
    
    private func getMarvelUrl(limit: Int = MarvelServiceSettings.defaultLimit, offset: Int = MarvelServiceSettings.defaultOffset) -> String
    {
        let ts = Date().timeIntervalSince1970 * 1_000_000
        let toHash = "\(ts)\(MarvelServiceSettings.privateKey)\(MarvelServiceSettings.publicKey)"
        debugPrint("\(MarvelServiceSettings.serviceUrl)?ts=\(ts)&apikey=\(MarvelServiceSettings.publicKey)&hash=\(MD5(string: toHash))&limit=\(limit)&offset=\(offset)")
        return "\(MarvelServiceSettings.serviceUrl)?ts=\(ts)&apikey=\(MarvelServiceSettings.publicKey)&hash=\(MD5(string: toHash))&limit=\(limit)&offset=\(offset)"
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

protocol CharactersServiceDelegate: AnyObject
{
    func charactersServiceDelegateDidUpdate(_: CharactersService, append: Bool)
}
