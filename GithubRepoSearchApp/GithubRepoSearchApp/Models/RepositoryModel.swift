////
////  RepositoryModel.swift
////  RepoSearch
////
////  Created by Deepashri Khawase on 27.05.19.
////  Copyright © 2019 Deep Yoga. All rights reserved.
////
import Foundation

// MARK: - RepositoryResponse
struct RepositoryResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: RepositoryResponse convenience initializers and mutators
extension RepositoryResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RepositoryResponse.self, from: data)
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
        totalCount: Int? = nil,
        incompleteResults: Bool? = nil,
        items: [Repository]? = nil
        ) -> RepositoryResponse {
        return RepositoryResponse(
            totalCount: totalCount ?? self.totalCount,
            incompleteResults: incompleteResults ?? self.incompleteResults,
            items: items ?? self.items
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Repository
struct Repository: Codable {
    let name :String
    let owner: Owner
    let itemDescription: String?
    let subscribersURL: String
    let forksCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case itemDescription = "description"
        case subscribersURL = "subscribers_url"
        case forksCount = "forks_count"
    }
}

// MARK: Item convenience initializers and mutators
extension Repository {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Repository.self, from: data)
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
        name: String? = nil,
        owner: Owner? = nil,
        itemDescription: String?? = nil,
        subscribersURL: String? = nil,
        forksCount: Int? = nil
        ) -> Repository {
        return Repository(
            name: name ?? self.name,
            owner: owner ?? self.owner,
            itemDescription: itemDescription ?? self.itemDescription,
            subscribersURL: subscribersURL ?? self.subscribersURL,
            forksCount: forksCount ?? self.forksCount
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Owner
struct Owner: Codable {
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}

// MARK: Owner convenience initializers and mutators
extension Owner {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Owner.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    func with(
        avatarURL: String? = nil
        ) -> Owner {
        return Owner(
            avatarURL: avatarURL ?? self.avatarURL
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders
func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
