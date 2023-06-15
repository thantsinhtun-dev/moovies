//
//  ErrorResponse.swift
//  Moovies
//
//  Created by Thant Sin Htun on 12/06/2023.
//

enum ErrorResponse: Error {
    case parsing(description: String)
    case network(description: String)
    
}
