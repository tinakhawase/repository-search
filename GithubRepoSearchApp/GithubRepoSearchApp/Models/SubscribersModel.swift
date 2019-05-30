//
//  SubscribersModel.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 30.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

// MARK: - SubscibersModelElement
struct SubscibersModelElement: Codable {
    let login: String
    
    enum CodingKeys: String, CodingKey {
        case login
    }
}

// MARK: SubscibersModelElement convenience initializers and mutators

extension SubscibersModelElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SubscibersModelElement.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        login: String? = nil
        ) -> SubscibersModelElement {
        return SubscibersModelElement(
            login: login ?? self.login
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias SubscibersModel = [SubscibersModelElement]

extension Array where Element == SubscibersModel.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SubscibersModel.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
