//
//  MovieAPIController.swift
//  CoreDataFavoriteMovies
//
//  Created by Parker Rushton on 11/1/22.
//

import Foundation

class MovieAPIController {
    
    
    struct SearchResponse: Decodable {
        var movies: [APIMovie]
        
        
        enum CodingKeys: String, CodingKey {
            case movies = "Search"
        }
        
        init(movies: [APIMovie]) {
            self.movies = movies
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            movies = try container.decode([APIMovie].self, forKey: .movies)
            
        }
    }
        
        let baseURL = URL(string: "http://www.omdbapi.com/")!
        let apiKey = "237cb57b"
        
        
        
        func fetchMovies(with searchTerm: String) async throws -> [APIMovie] {
            var searchURL = baseURL
            let apiKeyItem = URLQueryItem(name: "apiKey", value: apiKey)
            let searchItem = URLQueryItem(name: "s", value: searchTerm)
            searchURL.append(queryItems: [searchItem, apiKeyItem])
            
            let (data, _) = try await URLSession.shared.data(from: searchURL)
            
            let jsonDecoder = JSONDecoder()
            let searchResponse = try jsonDecoder.decode(SearchResponse.self, from: data)
            
            return searchResponse.movies
            //        return fakeMovies()
        }
        
        
        
        //    private func fakeMovies() -> [APIMovie] {
        //        let posterURL1 = URL(string: "https://m.media-amazon.com/images/M/MV5BN2ZkNDgxMjMtZmRiYS00MzFkLTk5ZjgtZDJkZWMzYmUxYjg4XkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg")
        //        let mockMovie1 = APIMovie(title: "Nacho Libre", year: "2006", imdbID: "tt0457510", posterURL: posterURL1)
        //        let posterURL2 = URL(string: "https://m.media-amazon.com/images/M/MV5BNjYwNTA3MDIyMl5BMl5BanBnXkFtZTYwMjIxNjA3._V1_SX300.jpg")
        //        let mockMovie2 = APIMovie(title: "Napoleon Dynamite", year: "2004", imdbID: "tt0374900", posterURL: posterURL2)
        //        let mockMovie3 = APIMovie(title: "Unknown Thriller", year: "not sure", imdbID: "tt03948", posterURL: nil)
        //        return [mockMovie1, mockMovie2, mockMovie3]
        //    }
        
    }

