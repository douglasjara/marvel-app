//
//  CharacterDataContainer.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

struct CharacterDataContainer: Codable
{
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [Character]
}
