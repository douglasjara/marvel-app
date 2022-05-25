//
//  CharacterViewController.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 23/5/21.
//

import UIKit

class CharacterViewController: UIViewController
{
    private var characterViewModel: CharacterViewModel
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var comicsContentView: UIStackView!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var seriesContentView: UIStackView!
    @IBOutlet weak var storiesLabel: UILabel!
    @IBOutlet weak var storiesContentView: UIStackView!
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var eventsContentView: UIStackView!
    
    init(characterViewModel: CharacterViewModel) {
        self.characterViewModel = characterViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(characterViewModel: CharacterViewModel(character: Character()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = characterViewModel.name
        
        imageView.loadCachedImageWithUrlString(urlString: characterViewModel.imageUrl)
        descriptionText.text = characterViewModel.description
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureViewElementsConstraints()

        addItemsToView(items: characterViewModel.comics.items, container: comicsContentView)
        addItemsToView(items: characterViewModel.stories.items, container: storiesContentView)
        addItemsToView(items: characterViewModel.series.items, container: seriesContentView)
        addItemsToView(items: characterViewModel.events.items, container: eventsContentView)
    }
    
    private func configureViewElementsConstraints() {
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        descriptionText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        comicsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        comicsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        comicsContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        comicsContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        seriesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        seriesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        seriesContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        seriesContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        storiesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        storiesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        storiesContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        storiesContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        eventsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        eventsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        eventsContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        eventsContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    private func addItemsToView<T: Collection>(items: T, container: UIStackView) {
        if items.count > 0 {
            for item in items {
                let itemMirror = Mirror(reflecting: item)
                DispatchQueue.main.async {
                    let nameLabel: UILabel = {
                        let label = UILabel()
                        label.text = itemMirror.children.first(where: { l,v in return l == "name" })?.value as? String
                        label.textColor = .lightGray
                        label.font = .systemFont(ofSize: 12)
                        label.numberOfLines = 0
                        return label
                    }()
                    
                    container.addArrangedSubview(nameLabel)
                }
            }
        } else {
            DispatchQueue.main.async {
                let nameLabel: UILabel = {
                    let label = UILabel()
                    label.text = "No data avaliable"
                    label.textColor = .lightGray
                    label.font = .systemFont(ofSize: 12)
                    label.numberOfLines = 0
                    return label
                }()
                
                container.addArrangedSubview(nameLabel)
            }
        }
    }
}
