//
//  CharacterViewModel.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

class CharacterDataWrapperViewModel
{
    private var characterDataWrapper: CharacterDataWrapper
    
    init (characterDataWrapper: CharacterDataWrapper) {
        self.characterDataWrapper = characterDataWrapper
    }
    
    var code: Int { get { return self.characterDataWrapper.code } }
    var status: String { get { return self.characterDataWrapper.status } }
    var copyright: String { get { return self.characterDataWrapper.copyright } }
    var attributionText: String { get { return self.characterDataWrapper.attributionText } }
    var attributionHTML: String { get { return self.characterDataWrapper.attributionHTML } }
    var data: CharacterDataContainer { get { return self.characterDataWrapper.data } }
    var etag: String { get { return self.characterDataWrapper.etag } }
}
