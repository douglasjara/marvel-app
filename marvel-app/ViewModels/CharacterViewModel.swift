//
//  CharacterViewModel.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

class CharacterViewModel
{
    private var character: Character
    
    init (character: Character) {
        self.character = character
    }
    
    var id: Int { get { return self.character.id! } }
    var name: String { get { return self.character.name! } }
    var description: String {
        get {
            if let description = self.character.description {
                return description == "" ? "Description is not avaliable" : description
            }
            return self.character.description!
        }
    }
    var imageUrl: String { get { return "\(self.character.thumbnail!.path).\(self.character.thumbnail!.ext)" } }
    
    var modified: String { get { return self.character.modified! } }
    var resourceURI: String { get { return self.character.resourceURI! } }
    var urls: [Url] { get { return self.character.urls! } }
    
    var comics: ComicList { get { return self.character.comics! } }
    var stories: StoryList { get { return self.character.stories! } }
    var events: EventList { get { return self.character.events! } }
    var series: SeriesList { get { return self.character.series! } }
}
