//
//  MockCharactersService.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 26/5/22.
//

import Foundation

final class MockCharactersService: CharactersService
{
    override func getData(limit: Int, offset: Int) {
        debugPrint("Using mock!")
        if let characterDataWrapper = Utilities.parseJson(jsonName: "Characters", model: CharacterDataWrapper.self) {
            DispatchQueue.main.async {
                self.characterDataWrapper = characterDataWrapper
                self.delegate?.charactersServiceDelegateDidUpdate(self, append: false)
            }
        }
    }
}
