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
    weak var delegate: CharactersServiceDelegate?    
    
    init()
    {
        debugPrint("Performing an API request")
        getCharactersFromAPI()
    }
    
    public func refreshData()
    {
        debugPrint("Refreshing data from API!")
        getCharactersFromAPI()
    }
    
    private func getCharactersFromAPI()
    {
        let service = APIManager(url: getMarvelUrl())
        service.get() { (characterDataWrapper: CharacterDataWrapper?) in
            if let characterDataWrapper = characterDataWrapper {
                self.delegate?.charactersServiceDelegateDidUpdate(self, didSetCharacters: characterDataWrapper)
            }
        }
    }
    
    private func getMarvelUrl() -> String
    {
        let ts = Date().timeIntervalSince1970 * 1_000_000
        let toHash = "\(ts)\(MarvelServiceSettings.privateKey ?? "")\(MarvelServiceSettings.publicKey)"
        return MarvelServiceSettings.serviceUrl+"?ts=\(ts)&apikey=\(MarvelServiceSettings.publicKey)&hash=\(MD5(string: toHash))"
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
    func charactersServiceDelegateDidUpdate(_: CharactersService, didSetCharacters characters: CharacterDataWrapper)
}
