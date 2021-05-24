//
//  CharacterCell.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

import UIKit

class CharacterCell: UITableViewCell
{
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.backgroundColor = .black
        label.alpha = 0.7
        return label
    }()
    
    var characterViewModel: CharacterViewModel?
    {
        didSet {
            self.updateViews()
        }
    }
    
    static let identifier = "characterCellIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(titleLabel)
        
        characterImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        characterImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        characterImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: characterImageView.leftAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: characterImageView.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(style: .default, reuseIdentifier: Self.identifier)
    }
    
    func updateViews() {
        guard let characterViewModel = self.characterViewModel else { return }
        
        self.titleLabel.text = characterViewModel.name
        self.characterImageView.loadCachedImageWithUrlString(urlString: characterViewModel.imageUrl)
    }
}
