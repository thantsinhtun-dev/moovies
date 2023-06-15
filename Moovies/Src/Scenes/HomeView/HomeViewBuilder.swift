//
//  HomeViewBuilder.swift
//  Moovies
//
//  Created by Thant Sin Htun on 14/06/2023.
//

import Foundation
import SwiftUI

enum HomeViewBuilder {
    static func makeMovieDetailView(
        showDetail:Binding<Bool>,
        forMovieId movieId:String,
        theMovieFetcher: TheMovieFetcher
    )-> some View{
        let viewModel = DetailViewModel(theMovieFetcher: theMovieFetcher, movieId: movieId)
        return DetailView(showDetail: showDetail, viewModel: viewModel)
    }
}
