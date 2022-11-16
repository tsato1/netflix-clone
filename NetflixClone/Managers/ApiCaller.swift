//
//  ApiCaller.swift
//  NetflixClone
//
//  Created by Takahide Sato on 10/6/22.
//

import Foundation

struct Constant {
    static let API_KEY = ""
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let YOUTUBE_API_KEY = ""
    static let YOUTUBE_BASE_URL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum ApiError: Error {
    case FailToGetData
}

class ApiCaller {
    static let shared = ApiCaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE_URL)/movie/upcoming?api_key=\(Constant.API_KEY)") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                //let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                
                completion(.success(result.results))
            }
            catch {
                completion(.failure(ApiError.FailToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE_URL)/trending/tv/day?api_key=\(Constant.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

                let result = try JSONDecoder().decode(TitleResponse.self, from: data)
//                print(result)
                completion(.success(result.results))
            }
            catch {
//                print(error.localizedDescription)
                completion(.failure(ApiError.FailToGetData))
            }
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE_URL)/trending/movie/day?api_key=\(Constant.API_KEY)&signature=en-US&page=1") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                //let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(TitleResponse.self, from: data)
//                print(result)
                completion(.success(result.results))
            }
            catch {
//                print(error.localizedDescription)
                completion(.failure(ApiError.FailToGetData))
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE_URL)/movie/popular?api_key=\(Constant.API_KEY)&signature=en-US&page=1") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                //let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(TitleResponse.self, from: data)
//                print(result)
                completion(.success(result.results))
            }
            catch {
//                print(error.localizedDescription)
                completion(.failure(ApiError.FailToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE_URL)/movie/top_rated?api_key=\(Constant.API_KEY)&signature=en-US&page=1") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                //let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(TitleResponse.self, from: data)
//                print(result)
                completion(.success(result.results))
            }
            catch {
//                print(error.localizedDescription)
                completion(.failure(ApiError.FailToGetData))
            }
        }
        
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE_URL)/discover/movie?api_key=\(Constant.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=true&page=1&with_watch_monetization_types=flatrate") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(result.results))
            }
            catch {
                completion(.failure(ApiError.FailToGetData))
            }
        }
        
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constant.BASE_URL)/search/movie?api_key=\(Constant.API_KEY)&query=\(query)") else { return }
            
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(result.results))
            }
            catch {
                completion(.failure(ApiError.FailToGetData))
            }
        }
        
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constant.YOUTUBE_BASE_URL)q=\(query)&key=\(Constant.YOUTUBE_API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(result.items[0]))
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(result)
            }
            catch {
//                print(error.localizedDescription)
                completion(.failure(ApiError.FailToGetData))
            }
        }
        
        task.resume()
    }
    
}
