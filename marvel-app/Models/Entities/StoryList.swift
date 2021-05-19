//
//  StoryList.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 19/5/21.
//

struct StoryList: Codable
{
    var available: Int
    var returned: Int
    var collectionURI: String
    var items: [StorySummary]
}
