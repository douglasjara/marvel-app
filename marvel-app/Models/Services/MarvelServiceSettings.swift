//
//  ServiceSettings.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

import Foundation

struct MarvelServiceSettings
{
    static let publicKey = "7dd6b1c293a76e31114fe7a3734e446d"
    static let privateKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    static let serviceUrl = "https://gateway.marvel.com:443/v1/public/characters"
}
