//
//  MovieResponse.swift
//  Moovies
//
//  Created by Thant Sin Htun on 12/06/2023.
//

import Foundation

struct MovieResponseVO: Codable {
    let dates: Dates?
    let page: Int
    let results: [MovieVO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Codable {
    let maximum, minimum: String
}


