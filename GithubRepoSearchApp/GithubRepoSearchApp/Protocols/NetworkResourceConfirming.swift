//
//  NetworkResourceConfirming.swift
//  GithubRepoSearchApp
//
//  Created by Deepashri Khawase on 31.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

protocol NetworkResourceConfirming {
        // override this for each APIResource and create the URL based on this
        var baseUrl: String { get }
        var httpMethod: String { get set }
        var headers: [String: String] { get set }
        // Implement this method to get the URLRequest needed for URLSession
        func getUrlRequest() -> URLRequest
    
    
}
