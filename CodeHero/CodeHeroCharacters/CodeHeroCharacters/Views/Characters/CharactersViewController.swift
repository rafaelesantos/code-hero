//
//  CharactersViewController.swift
//  CodeHeroCharacters
//
//  Created by Rafael Escaleira on 17/07/21.
//

import UIKit
import CodeHeroModels
import CodeHeroPagination

public class CharactersViewController: UIViewController {
    let tableView = UITableView()
    var paginationView: PaginationView!
    let viewModel = CharactersViewModel()
    var searchController = UISearchController(searchResultsController: nil)
    
    public init() {
        super.init(nibName: "CharactersViewController", bundle: Bundle(for: CharactersViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "rectangle.stack.person.crop.fill"), tag: 0)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.setupView()
        
        viewModel.character.bind(to: self.tableView.rx.items(cellIdentifier: "CharacterTableViewCell", cellType: CharacterTableViewCell.self)) { _, character, cell in
            self.tableView.separatorStyle = self.viewModel.character.value.isEmpty == false ? .singleLine : .none
            self.paginationView.maxOffset = self.viewModel.maxOffset
            cell.setCell(character: character)
        }.disposed(by: viewModel.disposeBag)
        
        self.tableView.rx.modelSelected(Character.CharacterData.Result.self).subscribe(onNext: { [weak self] character in
            let controllerDetail = CharacterDetailViewController(character: character)
            guard let row = self?.viewModel.character.value.firstIndex(where: { $0.id == character.id }) else { return }
            self?.present(controllerDetail, animated: true, completion: { self?.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true) })
        }).disposed(by: viewModel.disposeBag)
        
        viewModel.bindScrollToTop = {
            self.tableView.separatorStyle = self.viewModel.character.value.isEmpty == false ? .singleLine : .none
            if self.viewModel.character.value.isEmpty == false {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
            }
        }
        
        viewModel.bindMode = { mode in
            self.paginationView.setCurrentOffset(mode == .search ? self.viewModel.currentPageFind : self.viewModel.offset)
        }
    }
    
    private func setupView() {
        self.setSearchBar(searchController: self.searchController, viewModel, viewModel)
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        view.addSubview(self.tableView)
        
        self.paginationView = PaginationView(frame: CGRect(x: 15, y: 200, width: 400, height: 60))
        self.paginationView.delegate = viewModel
        view.insertSubview(self.paginationView, aboveSubview: self.tableView)
        
        let nib = UINib(nibName: "CharacterTableViewCell", bundle: Bundle(for: CharacterTableViewCell.self))
        self.tableView.register(nib, forCellReuseIdentifier: "CharacterTableViewCell")
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0)
        ])
        
        self.paginationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.paginationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -105),
            self.paginationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    func setSearchBar(searchController: UISearchController, placeholder: String = "Search", _ searchBarDelegate: UISearchBarDelegate, _ searchResultsUpdater: UISearchResultsUpdating) {
        searchController.searchResultsUpdater = searchResultsUpdater
        searchController.searchBar.delegate = searchBarDelegate
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = placeholder
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
    }
}
