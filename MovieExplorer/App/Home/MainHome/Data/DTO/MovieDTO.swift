//
//  MovieDTO.swift
//  MovieExplorer
//
//  Created by Diab on 31/08/2025.
//

import Foundation

struct MovieApiResponse: Codable {
    var page: Int?
    var results: [MovieDTO]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieDTO
struct MovieDTO: Codable {
    var id: Int
    var title: String?
    var posterPath:String?
    var isFavourite:Bool

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        isFavourite = false
    }
}


extension MovieDTO:MovieCellDataSource{
    
    var posterURL: String {
        return "https://image.tmdb.org/t/p/w500" + (posterPath ?? "")
    }
    
    var isMovieFavourite: Bool{
        get{
            return isFavourite
        }
        set{
            isFavourite = newValue
        }
    }
    
    
}
