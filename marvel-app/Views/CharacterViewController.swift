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
        
        view.backgroundColor = .black
        navigationItem.title = characterViewModel.name
        
        imageView.loadCachedImageWithUrlString(urlString: characterViewModel.imageUrl)
        descriptionText.text = characterViewModel.description
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureViewElementsConstraints()
        configureScrollView()
    }
    
    func configureScrollView() {
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
    
    func configureViewElementsConstraints() {
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        descriptionText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
