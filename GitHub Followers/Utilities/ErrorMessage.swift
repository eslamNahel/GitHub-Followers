//
//  ErrorMessage.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 03/11/2021.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUserName        = "This userName is invalid, please try again! 😃"
    case unableToComplete       = "Opps! an error occurred, please try again! 🤷🏻‍♂️"
    case invalidResponse        = "Something bad happened, please try again! 😅"
    case invalidData            = "Couldn't complete the response, please try again! 🙄"
    case invalidToSaveFavorite  = "Hey! sorry, we couldn't save this use to favorites! 🥺"
    case alreadyInFavorites     = "wait what? this user is already in favorites list! 🙂"
}

