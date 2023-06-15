//
//  TheMovieFetcher.swift
//  Moovies
//
//  Created by Thant Sin Htun on 12/06/2023.
//

import Foundation
import Combine

protocol TheMovieFetchable {
    func getNowShowing(
        forPage page:Int?
    )->AnyPublisher<MovieResponseVO, ErrorResponse>
    func getPopularMovies(
        forPage page:Int?
    )->AnyPublisher<MovieResponseVO, ErrorResponse>
    
    func getGenreList()->AnyPublisher<GenreResponseVO, ErrorResponse>
    
    func getMovieDetail(
        forMovieId movieId:String
    ) -> AnyPublisher<MovieDetailResponseVO,ErrorResponse>
    
    func getCastList(
        forMovieId movieId:String
    ) -> AnyPublisher<CastResponseVO,ErrorResponse>
    
    
}

class TheMovieFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension TheMovieFetcher : TheMovieFetchable {
    func getGenreList() -> AnyPublisher<GenreResponseVO, ErrorResponse> {
        return fetchData(with: makeGetGenreListComponents())
    }
    
    func getPopularMovies(
        forPage page: Int?
    ) -> AnyPublisher<MovieResponseVO, ErrorResponse> {
        return fetchData(with: makeGetPopularMoviesComponents(forPage: page))
    }
    
    
    func getNowShowing(
        forPage page: Int?
    ) -> AnyPublisher<MovieResponseVO, ErrorResponse> {
        return fetchData(with: makeGetNowShowingComponents(forPage: page))
    }
    
    func getMovieDetail(forMovieId movieId: String) -> AnyPublisher<MovieDetailResponseVO, ErrorResponse> {
        return fetchData(with: makeGetMovieDetailComponents(forMovieId: movieId))
    }
    
    func getCastList(forMovieId movieId: String) -> AnyPublisher<CastResponseVO, ErrorResponse> {
        return fetchData(with: makeGetCastListComponents(forMovieId: movieId))
    }
    
    private func fetchData<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, ErrorResponse> where T:Decodable {
        guard let url = components.url else {
            let error = ErrorResponse.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: {(data,response) in
                if let requestURL = response.url ?? url.baseURL {
                    print("Request URL: \(requestURL)")
                }
                
                // Log the response URL
                if let httpResponse = response as? HTTPURLResponse {
                    print("Response URL: \(httpResponse.url?.absoluteString ?? "")")
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response data: \(responseString ?? "")")
                }
            })
            .mapError{ error in
                    .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
}

private extension TheMovieFetcher {
    struct TheMovieDbAPI {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let path = "/3/movie/"
        static let key = "e889bd3874658fa4c656eabdd8b86b00"
        static let language = "en-US"
    }
    
    func makeGetNowShowingComponents(
        forPage page:Int?
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = TheMovieDbAPI.scheme
        components.host = TheMovieDbAPI.host
        components.path = TheMovieDbAPI.path + "/now_playing"
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TheMovieDbAPI.key),
            URLQueryItem(name: "language", value: TheMovieDbAPI.language),
            URLQueryItem(name: "page", value: "\(page ?? 1)")
            
        ]
        return components
    }
    func makeGetPopularMoviesComponents(
        forPage page:Int?
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = TheMovieDbAPI.scheme
        components.host = TheMovieDbAPI.host
        components.path = TheMovieDbAPI.path + "/popular"
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TheMovieDbAPI.key),
            URLQueryItem(name: "language", value: TheMovieDbAPI.language),
            URLQueryItem(name: "page", value: "\(page ?? 1)")
            
        ]
        return components
    }
    
    func makeGetGenreListComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = TheMovieDbAPI.scheme
        components.host = TheMovieDbAPI.host
        components.path = "/3/genre/movie/list"
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TheMovieDbAPI.key),
            URLQueryItem(name: "language", value: TheMovieDbAPI.language),
        ]
        return components
    }
    
    func makeGetMovieDetailComponents(
        forMovieId movieId:String
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = TheMovieDbAPI.scheme
        components.host = TheMovieDbAPI.host
        components.path = TheMovieDbAPI.path + "\(movieId)"
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TheMovieDbAPI.key),
            URLQueryItem(name: "language", value: TheMovieDbAPI.language),
            
        ]
        return components
    }
    
    func makeGetCastListComponents(
        forMovieId movieId:String
    )-> URLComponents {
        var components = URLComponents()
        components.scheme = TheMovieDbAPI.scheme
        components.host = TheMovieDbAPI.host
        components.path = TheMovieDbAPI.path + "\(movieId)/credits"
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TheMovieDbAPI.key),
            URLQueryItem(name: "language", value: TheMovieDbAPI.language),
            
        ]
        return components
    }
}
