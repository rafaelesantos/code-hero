//
//  CharacterDetailViewController.swift
//  CodeHeroCharacters
//
//  Created by Rafael Escaleira on 18/07/21.
//

import UIKit
import CodeHeroModels
import SafariServices

class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heroTitle: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroBackgroundImage: UIImageView!
    
    var character: Character.CharacterData.Result
    
    public init(character: Character.CharacterData.Result) {
        self.character = character
        super.init(nibName: "CharacterDetailViewController", bundle: Bundle(for: CharacterDetailViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.view.backgroundColor = .secondarySystemBackground
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.heroTitle.text = character.name?.uppercased()
        if let thumbnail = character.thumbnail?.path?.replacingOccurrences(of: "http://", with: "https://"), let format = character.thumbnail?._extension {
            var imageURL = thumbnail + "/landscape_incredible." + format
            self.heroImage.downloaded(from: imageURL)
            imageURL = thumbnail + "/portrait_incredible." + format
            self.heroBackgroundImage.downloaded(from: imageURL)
        }
    }
    
    @IBAction func dismissButton() {
        self.dismiss(animated: true, completion: {})
    }
}

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        else if section == 1 { return character.comics?.items?.count ?? 0 }
        else if section == 2 { return character.series?.items?.count ?? 0 }
        else if section == 3 { return character.stories?.items?.count ?? 0 }
        else if section == 4 { return character.events?.items?.count ?? 0 }
        else { return character.urls?.count ?? 0 }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Description" }
        else if section == 1 { return "Comics" }
        else if section == 2 { return "Series" }
        else if section == 3 { return "Stories" }
        else if section == 4 { return "Events" }
        else { return "URL's" }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        cell.textLabel?.numberOfLines = 0
        if indexPath.section == 0 {
            cell.backgroundColor = .clear
            cell.textLabel?.text = character.description?.isEmpty == false ? character.description : "No description"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = character.comics?.items?[indexPath.row].name
        } else if indexPath.section == 2 {
            cell.textLabel?.text = character.series?.items?[indexPath.row].name
        } else if indexPath.section == 3 {
            cell.textLabel?.text = character.stories?.items?[indexPath.row].name
        } else if indexPath.section == 4 {
            cell.textLabel?.text = character.events?.items?[indexPath.row].name
        } else if indexPath.section == 5 {
            cell.textLabel?.text = character.urls?[indexPath.row].url
        }
        return cell
    }
}
