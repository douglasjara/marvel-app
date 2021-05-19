//
//  ComicList.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 19/5/21.
//

struct ComicList: Codable
{
    var available: Int
    var returned: Int
    var collectionURI: String
    var items: [ComicSummary]
}
