//
//  DataHelper.swift
//  CNRand
//
//  Created by Augusto Reis on 04/07/19.
//  Copyright © 2019 Augusto Reis. All rights reserved.
//
import Foundation

struct DataHelper<T: Codable> {
    
    static func encodeToData(element: T) -> Data? {
        let jsonEncoder = JSONEncoder()
        guard let encodedElement = try? jsonEncoder.encode(element) else { return nil }
        return encodedElement
    }
    
    static func decode(data: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        guard let element = try? jsonDecoder.decode(T.self, from: data) else { return nil}
        return element
    }
}

