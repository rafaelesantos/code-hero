//
//  CharacterTableViewCell.swift
//  CodeHeroCharacters
//
//  Created by Rafael Escaleira on 17/07/21.
//

import UIKit
import CodeHeroModels
import CodeHeroAPI

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroTitle: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroImageLoading: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.heroTitle.numberOfLines = 2
        self.heroDescription.numberOfLines = 4
        self.heroImage.clipsToBounds = true
        self.heroImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(character: Character.CharacterData.Result) {
        self.heroTitle.text = character.name?.uppercased()
        self.heroDescription.text = character.description ?? "No description"
        if self.heroImage.image == nil { self.heroImageLoading.startAnimating() }
        else { self.heroImageLoading.stopAnimating() }
        if let thumbnail = character.thumbnail?.path?.replacingOccurrences(of: "http://", with: "https://"), let format = character.thumbnail?._extension {
            let imageURL = thumbnail + "/landscape_incredible." + format
            self.heroImage.downloaded(from: imageURL, activityIndicator: self.heroImageLoading)
        }
    }
    
    override func prepareForReuse() {
        self.heroTitle.text = ""
        self.heroDescription.text = ""
        self.heroImage.image = nil
        self.heroImageLoading.startAnimating()
    }
}
