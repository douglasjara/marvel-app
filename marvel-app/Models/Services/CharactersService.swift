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
    internal var characterDataWrapper = CharacterDataWrapper()
    weak var delegate: CharactersServiceDelegate?
    private let fileURL: URL
    private let fileManager = FileManager.default
    private var localRequests = 0
    
    init()
    {
        let fileName = "characters"
        let documentsURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryURL = documentsURL.appendingPathComponent("Marvel", isDirectory: true)
        self.fileURL = directoryURL.appendingPathComponent("\(fileName).json", isDirectory: false)
        
        debugPrint("Init: Getting data!")
        getData(limit: MarvelServiceSettings.defaultLimit, offset: MarvelServiceSettings.defaultOffset)
    }
    
    public func refreshData()
    {
        debugPrint("Refreshing data!")
        getData(limit: MarvelServiceSettings.defaultLimit, offset: MarvelServiceSettings.defaultOffset)
    }
    
    public func getData(limit: Int, offset: Int)
    {
        if MarvelServiceSettings.getOnlineData {
            getCharactersFromAPI(limit: limit, offset: offset)
        } else {
            getCharactersFromLocal()
        }
    }
    
    private func getCharactersFromLocal()
    {
        //TODO: Pagination in local
        if self.localRequests == 0 {
            debugPrint("Getting data from LOCAL!")
            DispatchQueue.main.async {
                if let charactersFileContents = self.fileManager.contents(atPath: self.fileURL.path) {
                    do {
                        let characterDataWrapper = try JSONDecoder().decode(CharacterDataWrapper.self, from: charactersFileContents)
                        self.characterDataWrapper = characterDataWrapper
                        self.delegate?.charactersServiceDelegateDidUpdate(self, append: false)
                        self.localRequests += 1
                    } catch {
                        debugPrint("Can't retrieve characters data from file")
                    }
                } else {
                    debugPrint("No contents")
                }
            }
        }
    }
    
    private func getCharactersFromAPI(limit: Int, offset: Int)
    {
        debugPrint("Getting data from API!")
        let service = APIManager(url: getMarvelUrl(limit: limit, offset: offset))
        service.get() { (characterDataWrapper: CharacterDataWrapper?) in
            if let characterDataWrapper = characterDataWrapper {
                self.characterDataWrapper = characterDataWrapper
                if (offset == MarvelServiceSettings.defaultOffset) {
                    self.delegate?.charactersServiceDelegateDidUpdate(self, append: false)
                    
                    let data = try! JSONEncoder().encode(characterDataWrapper)
                    
                    do {
                        let directory = self.fileURL.deletingLastPathComponent()
                        try? FileManager.default.removeItem(at: directory)
                        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
                        try data.write(to: self.fileURL, options: .atomic)
                        
                        debugPrint("Directorio Marvel creado: \(self.fileURL)")
                    } catch let fileError {
                        debugPrint("\(CharactersService.self): (getCharactersFromAPI) Error creating file: \(fileError)")
                    }
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
