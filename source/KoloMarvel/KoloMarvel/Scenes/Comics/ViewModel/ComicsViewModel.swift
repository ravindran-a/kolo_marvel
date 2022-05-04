//
//  ComicsViewModel.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation

enum ComicsFilterType: String {
    case none, lastWeek, thisWeek, nextWeek, thisMonth
    static func getAllValues() -> [ComicsFilterType] {
        return [.none, .lastWeek, .thisWeek, .nextWeek, .thisMonth]
    }
}

class ComicsViewModel {
    
    let allFilterTypes: [ComicsFilterType] = ComicsFilterType.getAllValues()
    var comics: [Comic] = [Comic]()
    let pageLimit: Int = 20
    var currentPage: Int = 0
    var totalPage: Int = 0
    var currentFilterType: ComicsFilterType = .none
    
    func getComics(refreshData: Bool = false, loadNextPage: Bool = false, completionHandler: ((Error?) -> Void)? = nil) {
        if refreshData {
            currentPage = 0
            totalPage = 0
            comics.removeAll()
        }
        if loadNextPage {
            currentPage += 1
        }
        let offset = pageLimit * currentPage
        var url: String = ""
        if self.currentFilterType == .none {
            url = APIEndPoints.Comics.getAllComics(limit: self.pageLimit, offset: offset).url
        } else {
            url = APIEndPoints.Comics.filterComics(type: self.currentFilterType.rawValue, limit: self.pageLimit, offset: offset).url
        }
        ApiManager.shared.dataTask(serviceURL: url) { [weak self] data, error in
            guard let responseData = data, error == nil else {
                completionHandler?(error)
                return
            }
            do {
                let responseModel = try JSONDecoder().decode(ComicResponse.self, from: responseData)
                if let data = responseModel.data, let comics = data.results {
                    self?.totalPage = ((data.total ?? 0) % (self?.pageLimit ?? 0) == 0) ? ((data.total ?? 0) / (self?.pageLimit ?? 0)) : (((data.total ?? 0) / (self?.pageLimit ?? 0)) + 1)
                    if self?.currentPage ?? 0 == 0 {
                        self?.comics = comics
                    } else {
                        self?.comics.append(contentsOf: comics)
                    }
                }
                completionHandler?(nil)
            } catch let error {
                completionHandler?(error)
            }
        }
    }
    
    func getComicsCount() -> Int {
        return self.comics.count
    }
    
    func getComic(index: Int) -> Comic? {
        return self.comics.count > index ? self.comics[index] : nil
    }
    
    func getFilterCount() -> Int {
        self.allFilterTypes.count
    }
    
    func getFilterString(index: Int) -> String {
        switch self.allFilterTypes[index] {
        case .none:
            return "None"
        case .lastWeek:
            return "Released last week"
        case .thisWeek:
            return "Releasing this week"
        case .nextWeek:
            return "Releasing next week"
        case .thisMonth:
            return "Releasing this month"
        }
    }
    
    func shouldLoadNextPage(indexPath: IndexPath) -> Bool {
        return currentPage < totalPage && indexPath.row == comics.count - 1
    }
    
    func setFilterType(filterType: ComicsFilterType) {
        self.currentFilterType = filterType
    }
    
}
