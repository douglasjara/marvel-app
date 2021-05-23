//
//  Character.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 19/5/21.
//

struct Character: Codable
{
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var resourceURI: String?
    var urls: [Url]?
    var thumbnail: Image?
    var comics: ComicList?
    var stories: StoryList?
    var events: EventList?
    var series: SeriesList?
}
