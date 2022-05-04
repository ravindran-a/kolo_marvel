//
//  CharactersViewModel.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation

class CharactersViewModel {
    
    var characters: [Character] = [Character]()
    var searchHistory: [String] = []
    let pageLimit: Int = 20
    var currentPage: Int = 0
    var totalPage: Int = 0
    var searchString: String = ""
    
    init() {
        if let cachedData = UserDefaultsManager.objectForKey(.searchHistory) as? Data,
           let cachedSearchHistory  = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(cachedData) as? [String] {
            self.searchHistory = cachedSearchHistory
        }
    }
    
    func getCharacters(refreshData: Bool = false, loadNextPage: Bool = false,
                       completionHandler: ((Error?) -> Void)? = nil) {
        if refreshData {
            currentPage = 0
            totalPage = 0
            characters.removeAll()
        }
        if loadNextPage {
            currentPage += 1
        }
        let offset = pageLimit * currentPage
        var url = ""
        if !self.searchString.isEmpty {
            url = APIEndPoints.Characters.searchCharacters(name: self.searchString, limit: self.pageLimit, offset: offset).url
        } else {
            url = APIEndPoints.Characters.getAllCharacters(limit: self.pageLimit, offset: offset).url
        }
        ApiManager.shared.dataTask(serviceURL: url) { [weak self] data, error in
            guard let responseData = data, error == nil else {
                completionHandler?(error)
                return
            }
            do {
                let responseModel = try JSONDecoder().decode(CharacterResponse.self, from: responseData)
                if let data = responseModel.data, let characters = data.results {
                    self?.totalPage = ((data.total ?? 0) % (self?.pageLimit ?? 0) == 0) ? ((data.total ?? 0) / (self?.pageLimit ?? 0)) : (((data.total ?? 0) / (self?.pageLimit ?? 0)) + 1)
                    if self?.currentPage ?? 0 == 0 {
                        self?.characters = characters
                    } else {
                        self?.characters.append(contentsOf: characters)
                    }
                }
                completionHandler?(nil)
            } catch let error {
                completionHandler?(error)
            }
        }
    }
    
    func getCharactersCount() -> Int {
        return self.characters.count
    }
    
    func getCharacter(index: Int) -> Character? {
        return self.characters.count > index ? self.characters[index] : nil
    }
    
    func getSearchHistoryCount() -> Int {
        return searchHistory.count
    }
    
    func getSearchHistoryString(index: Int) -> String {
        return searchHistory[index]
    }
    
    func addToSearchHistory(string: String) {
        if !string.isEmpty && !self.searchHistory.contains(string) {
            self.searchHistory.append(string)
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: searchHistory, requiringSecureCoding: false)
            UserDefaultsManager.setObject(encodedData, forKey: .searchHistory)
        }
    }
    
    func setSearchString(string: String) {
        self.searchString = string
        addToSearchHistory(string: string)
    }
    
    func shouldLoadNextPage(indexPath: IndexPath) -> Bool {
        return currentPage < totalPage && indexPath.row == characters.count - 1
    }
    
}
