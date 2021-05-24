//
//  CharacterViewController.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 23/5/21.
//

import UIKit

class CharacterViewController: UIViewController
{
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    let contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "picture"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cargando..."
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let comicsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Comics"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    let comicsContentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    let seriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Series"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    let seriesContentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    let storiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Stories"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    let storiesContentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    let eventsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Events"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    let eventsContentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    private var characterViewModel: CharacterViewModel
    
    init(characterViewModel: CharacterViewModel) {
        self.characterViewModel = characterViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(characterViewModel: CharacterViewModel(character: Character()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(imageView)
        contentView.addArrangedSubview(descriptionLabel)
        contentView.addArrangedSubview(descriptionText)
        contentView.addArrangedSubview(comicsLabel)
        contentView.addArrangedSubview(comicsContentView)
        contentView.addArrangedSubview(storiesLabel)
        contentView.addArrangedSubview(storiesContentView)
        contentView.addArrangedSubview(seriesLabel)
        contentView.addArrangedSubview(seriesContentView)
        contentView.addArrangedSubview(eventsLabel)
        contentView.addArrangedSubview(eventsContentView)
        
        view.backgroundColor = .black
        navigationItem.title = characterViewModel.name
        
        imageView.loadCachedImageWithUrlString(urlString: characterViewModel.imageUrl)
        descriptionText.text = characterViewModel.description
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureViewElementsConstraints()
        configureScrollView()
        addItemsToView(items: characterViewModel.comics.items, container: comicsContentView)
        addItemsToView(items: characterViewModel.stories.items, container: storiesContentView)
        addItemsToView(items: characterViewModel.series.items, container: seriesContentView)
        addItemsToView(items: characterViewModel.events.items, container: eventsContentView)
    }
    
    private func configureScrollView() {
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20).isActive = true
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
