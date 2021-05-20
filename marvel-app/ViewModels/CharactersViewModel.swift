//
//  CharactersViewModel.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

class CharactersViewModel: CharactersServiceDelegate
{
    private let charactersService: CharactersService
    weak var delegate: CharactersViewModelDelegate?
    
    init (charactersService: CharactersService)
    {
        self.charactersService = charactersService
        self.charactersService.delegate = self
    }
    
    public func refreshData()
    {
        charactersService.refreshData()
    }
       
    // MARK: - CharactersServiceDelegate
    func charactersServiceDelegateDidUpdate(_: CharactersService, didSetCharacters characters: CharacterDataWrapper)
    {
        let characterDataWrapperViewModel = CharacterDataWrapperViewModel(characterDataWrapper: characters)
        delegate?.charactersViewModelDidUpdateCharacters(self, characterDataWrapperViewModel: characterDataWrapperViewModel)
    }
}

protocol CharactersViewModelDelegate: AnyObject
{
    func charactersViewModelDidUpdateCharacters(_: CharactersViewModel, characterDataWrapperViewModel: CharacterDataWrapperViewModel)
}
