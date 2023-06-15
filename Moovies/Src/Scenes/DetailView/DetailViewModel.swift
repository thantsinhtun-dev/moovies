//
//  DetailViewModel.swift
//  Moovies
//
//  Created by Thant Sin Htun on 13/06/2023.
//

import SwiftUI
import Combine


class DetailViewModel : ObservableObject {
    private let theMovieFetcher : TheMovieFetcher
    let movieId : String
    
    @Published var movieVO : MovieDetailResponseVO?
    @Published var castList : [CastVO] = []
    
    private var disposables = Set<AnyCancellable>()
    
    
    init(theMovieFetcher:TheMovieFetcher,movieId:String){
        self.theMovieFetcher = theMovieFetcher
        self.movieId = movieId
        print("movie id",movieId)
        loadMovieDetail(forMovieId: movieId)
        loadCastList(forMovieId: movieId)
    }
    
    
    func loadMovieDetail(forMovieId movieId:String){
        theMovieFetcher
            .getMovieDetail(forMovieId: movieId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { competion in
                switch competion {
                    case .failure(let error):
                        print("error",error)
                        self.movieVO = nil
                    case .finished:
                        break
                }
            }, receiveValue: { data in
                self.movieVO = data
            })
            .store(in: &disposables)
    }
    

    func loadCastList(forMovieId movieId:String){
        theMovieFetcher
            .getCastList(forMovieId: movieId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {competion in
                switch competion {
                    case .failure(let error):
                        print("error",error)
                        self.castList = []
                    case .finished:
                        break
                }
                
            }, receiveValue: { data in
                self.castList = data.cast
            })
            .store(in: &disposables)
    }

}
