//
//  Repository.swift
//  GitHubRepositoryViewer
//
//  Created by AtsuyaSato on 2017/04/04.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Himotoki

struct Repository: Decodable {
    let fullName: String
    let ownerAvatarUrl: String
    let language: String?
    let url: String

    static func decode(_ e: Extractor) throws -> Repository {
        return try Repository(
            fullName: e <| "full_name",
            ownerAvatarUrl: e <| ["owner", "avatar_url"],
            language: e <|? "language",
            url: e <| "url"
        )
    }
}
