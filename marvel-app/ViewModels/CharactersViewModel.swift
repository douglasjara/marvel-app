//
//  CharactersViewModel.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

class CharactersViewModel: CharactersServiceDelegate
{
    private(set) var characterViewModels: [CharacterViewModel] = []
    private(set) var totalCharacters: Int = 0
    private var offset: Int = 0
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
    
    public func loadMoreData()
    {
        offset = offset + MarvelServiceSettings.defaultLimit
        charactersService.getData(limit: MarvelServiceSettings.defaultLimit, offset: offset)
    }
    
    private func updateCharacterViewModels(append: Bool = false)
    {
        if let totalCharacters = charactersService.characterDataWrapper.data?.total {
            self.totalCharacters = totalCharacters
        }
        
        var viewModels: [CharacterViewModel] = []
        
        if let characters = charactersService.characterDataWrapper.data?.results {
            for character in characters {
                viewModels.append(CharacterViewModel(character: character))
            }
        }
        
        if append {
            characterViewModels.append(contentsOf: viewModels)
        } else {
            characterViewModels = viewModels
        }
        
        delegate?.charactersViewModelDidUpdateCharacters(self)
    }
       
    // MARK: - CharactersServiceDelegate
    func charactersServiceDelegateDidUpdate(_: CharactersService, append: Bool)
    {
        updateCharacterViewModels(append: append)
    }
}

protocol CharactersViewModelDelegate: AnyObject
{
    func charactersViewModelDidUpdateCharacters(_: CharactersViewModel)
}
