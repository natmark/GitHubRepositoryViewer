//
//  Repository.swift
//  GitHubRepositoryViewer
//
//  Created by AtsuyaSato on 2017/04/04.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import Himotoki

struct Repository: Decodable {
    let fullName: String
    let ownerAvaterUrl: String?
    let updatedAt: String
    let url: String

    static func decode(_ e: Extractor) throws -> Repository {
        return try Repository(
            fullName: e <| "full_name",
            ownerAvaterUrl: e <|? ["owner", "avatar_url"],
            updatedAt: e <| "updated_at",
            url: e <| "url"
        )
    }
}
