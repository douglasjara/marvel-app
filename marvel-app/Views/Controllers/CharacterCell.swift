//
//  CharacterCell.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 20/5/21.
//

import UIKit

class CharacterCell: UITableViewCell
{    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var characterViewModel: CharacterViewModel?
    {
        didSet {
            self.updateViews()
        }
    }
    
    static let identifier = "characterCellIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews() {
        guard let characterViewModel = self.characterViewModel else { return }
        
        self.titleLabel.text = characterViewModel.name
        self.characterImageView.loadCachedImageWithUrlString(urlString: characterViewModel.imageUrl)
    }
}
