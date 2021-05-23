//
//  CharacterDataWrapper.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

struct CharacterDataWrapper: Codable
{
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var data: CharacterDataContainer?
    var etag: String?
}
