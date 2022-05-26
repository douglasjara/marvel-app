//
//  ViewController.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 19/5/21.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CharactersViewModelDelegate
{
    private var charactersViewModel: CharactersViewModel

    @IBOutlet weak var tableView: UITableView!
        
    init(charactersViewModel: CharactersViewModel) {
        self.charactersViewModel = charactersViewModel
        super.init(nibName: "CharactersView", bundle: nil)
    }
    
    required convenience init?(coder: NSCoder)
    {
        self.init(charactersViewModel: CharactersViewModel(charactersService: CharactersService()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CharacterCellView", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CharacterCell.identifier)
        
        view.addSubview(tableView)
        
        setupNavigationBar()
        self.title = "Marvel"
        
        tableView.delegate = self
        tableView.dataSource = self
        charactersViewModel.delegate = self
    }
       
    private func setupNavigationBar() {
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.prefersLargeTitles = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(CharacterViewController(characterViewModel: charactersViewModel.characterViewModels[indexPath.row]), animated: true)
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersViewModel.characterViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == charactersViewModel.characterViewModels.count - 1 {
            if charactersViewModel.totalCharacters > charactersViewModel.characterViewModels.count {
                charactersViewModel.loadMoreData()
            }
        }
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterCell.identifier,
            for: indexPath
        ) as! CharacterCell
        
        let character = charactersViewModel.characterViewModels[indexPath.row]
        cell.characterViewModel = character
        
        return cell
    }
    
    // MARK: - CharactersViewModelDelegate
    func charactersViewModelDidUpdateCharacters(_: CharactersViewModel) {
        self.tableView.reloadData()
    }
}

