//
//  API.swift
//  GitHubRepositoryViewer
//
//  Created by AtsuyaSato on 2017/04/04.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

protocol GitHubRequest: Request {

}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return object
    }
}

extension GitHubRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        return try decodeValue(object)
    }
}

struct FetchRepositoryRequest: GitHubRequest {
    var userName: String
    var path: String {
        return String(format: "/users/%@/repos", self.userName)
    }
    typealias Response = [Repository]

    var method: HTTPMethod {
        return .get
    }

    init(userName: String) {
        self.userName = userName
    }
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> FetchRepositoryRequest.Response {
        return try decodeArray(object)
    }
}
