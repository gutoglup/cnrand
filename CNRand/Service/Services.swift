//
//  Services.swift
//  CNRand
//
//  Created by Augusto Reis on 03/07/19.
//  Copyright © 2019 Augusto Reis. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionHandler = (Any) -> Void
typealias CompletionHanderOnError = (Error?) -> Void

class Services {

    private struct RequestURL {
        static let listCategories = "https://api.chucknorris.io/jokes/categories"
        static let messageByCategory = "https://api.chucknorris.io/jokes/random?category=<category>"
    }
    
    func listCategories(completionHandler: @escaping CompletionHandler, onError: @escaping CompletionHanderOnError) {
        Alamofire.request(RequestURL.listCategories).validate(statusCode: [200]).responseJSON { (response) in
            switch (response.result) {
            case .success(let data):
                var categories = [Category]()
                if let dataArray = data as? [String] {
                    dataArray.forEach({ (categoryString) in
                        let category = Category(title: categoryString)
                        categories.append(category)
                    })
                    completionHandler(categories)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func loadRandomPhraseByCategory(category: String, completionHandler: @escaping CompletionHandler, onError: @escaping CompletionHanderOnError) {
        let linkURL = RequestURL.messageByCategory.replacingOccurrences(of: "<category>", with: category)
        
        Alamofire.request(linkURL).validate(statusCode: [200]).responseJSON { (response) in
            switch (response.result) {
            case .success(let data):
                if let dataDictionary = data as? [String: Any],
                    let icon_url = dataDictionary["icon_url"] as? String,
                let url = dataDictionary["url"] as? String,
                let value = dataDictionary["value"] as? String {
                    let phrase = Phrase(icon_url: icon_url , url: url, value: value)
                    completionHandler(phrase)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
}
