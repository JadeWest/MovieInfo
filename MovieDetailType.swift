//
//  MovieDetailType.swift
//  MovieInfo
//
//  Created by User on 2020/05/28.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    let Title:String
    let Year:String     // 필요없음
    let Rated:String    // 필요없음
    let Released:String
    let Runtime:String
    let Genre:String
    let Director:String
    let Writer:String
    let Actors:String
    let Plot:String
    let Language:String // 필요없음
    let Country:String
    let Awards:String
    let Poster:String   // 필요없음
    let Ratings:[Ratings]   // 로튼토마토만
    let Metascore:String   // 필요없음
    let imdbRating:String   // 필요없음
    let imdbVotes:String   // 필요없음
    let imdbID:String   // 필요없음
    let type:String   // 필요없음
    let DVD:String?   // 필요없음
    let BoxOffice:String?   // 필요없음
    let Production:String?   // 필요없음
    let Website:String?
    let totalSeasons: String?// 필요없음
    let Response:String   // 필요없음
    
    enum CodingKeys:String, CodingKey {
        case Title, Year, Rated, Released, Runtime, Genre, Director, Writer, Actors, Plot, Language, Country, Awards, Poster, Metascore, imdbRating, imdbVotes, imdbID, DVD, BoxOffice, Production, Website, Response, totalSeasons
        case type = "Type"
        case Ratings
    }
    
    struct Ratings:Codable {
        let Source:String
        let Value:String
    }
    
    func dataException() -> String {
        return "\(self.Released)"
//        return """
//        Title: \(self.titleToSet ?? "No Title")\n
//        Released: \(movieDetail.Released)\n
//        Runtime: \(movieDetail.Runtime)\n
//        Genre: \(movieDetail.Genre)\n
//        Director: \(movieDetail.Director)\n
//        Writer: \(movieDetail.Writer)\n
//        Actors: \(movieDetail.Actors)\n
//        Plot: \(movieDetail.Plot)\n
//        Country: \(movieDetail.Country)\n
//        Awards: \(movieDetail.Awards)\n
//        Ratings: \(movieDetail.Ratings[1].Source) -  \(movieDetail.Ratings[1].Value)\n
//        """
//        MovieDetail.init(Title: "", Year: "", Rated: "", Released: "", Runtime: "", Genre: "", Director: "", Writer: "", Actors: "", Plot: "", Language: "", Country: "", Awards: "", Poster: "", Ratings: [], Metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", DVD: "", BoxOffice: "", Production: "", Website: "", Response: "")
    }

}
