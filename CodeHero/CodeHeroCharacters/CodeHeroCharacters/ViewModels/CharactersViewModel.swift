//
//  CharactersViewModel.swift
//  CodeHeroCharacters
//
//  Created by Rafael Escaleira on 17/07/21.
//

import Foundation
import CodeHeroAPI
import CodeHeroModels
import CodeHeroPagination
import RxCocoa
import RxSwift

public class CharactersViewModel: NSObject,
                                  UISearchResultsUpdating,
                                  UISearchBarDelegate,
                                  PaginationDelegate {
    var service: CharacterServiceProtocol
    var bindScrollToTop: () -> () = {  }
    var bindMode: (Mode) -> () = { mode in }
    var findHeroName: String?
    var maxOffset: Int = 4
    let character = BehaviorRelay<[Character.CharacterData.Result]>(value: [])
    let disposeBag = DisposeBag()
    
    enum Mode {
        case search, normal
    }
    
    private (set) var offset: Int = 1
    private (set) var currentPageFind: Int = 1
    
    init(query: CharacterQuery = .characters(orderBy: .descModified, offset: 1)) {
        self.service = CharacterService(query: query)
        super.init()
        self.fetchCharacters(query: query)
    }
    
    private func fetchCharacters(query: CharacterQuery) {
        self.service = CharacterService(query: query)
        self.service.fetchCharacterData { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let characters):
                self.character.accept(characters?.data?.results ?? [])
                self.maxOffset = (characters?.data?.total ?? 16) / 4
            }
        }
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.isEmpty == false {
            self.findHeroName = searchText
            self.fetchCharacters(query: .characters(nameStartsWith: searchText, orderBy: .ascName, limit: 4, offset: ((self.currentPageFind - 1) * 4) + 1))
            self.bindMode(.search)
        } else {
            self.findHeroName = nil
            self.currentPageFind = 1
            self.fetchCharacters(query: .characters(orderBy: .descModified, limit: 4, offset: ((self.offset - 1) * 4) + 1))
            self.bindMode(.normal)
        }
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.currentPageFind = 1
        self.findHeroName = nil
        self.fetchCharacters(query: .characters(orderBy: .descModified, limit: 4, offset: ((self.offset - 1) * 4) + 1))
        self.bindMode(.normal)
    }
    
    public func pagination(didSelected offset: Int) {
        if self.findHeroName?.isEmpty == false {
            self.currentPageFind = offset
        } else {
            self.offset = offset
        }
        self.bindScrollToTop()
        self.fetchCharacters(query: .characters(nameStartsWith: self.findHeroName, orderBy: .descModified, limit: 4, offset: ((offset - 1) * 4) + 1))
    }
}
