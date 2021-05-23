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
        characterImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        characterImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        characterImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(style: .subtitle, reuseIdentifier: Self.identifier)
    }
    
    func updateViews() {
        guard let characterViewModel = self.characterViewModel else { return }
        
        self.textLabel?.text = characterViewModel.name
        self.characterImageView.loadCachedImageWithUrlString(urlString: characterViewModel.imageUrl)
    }
}
