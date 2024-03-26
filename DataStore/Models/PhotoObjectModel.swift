//
//  PhotoObjectModel.swift
//  DataStore
//
//  Created by SCOTT CROWDER on 3/26/24.
//

import Foundation
import SwiftData

@Model
final class PhotoObject {
    var albumId: Int
    @Attribute(.unique)
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    init(albumId: Int, id: Int, title: String, url: String, thumbnailUrl: String) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
    convenience init(item: PhotoDTO) {
        self.init(
            albumId: item.albumId,
            id: item.id,
            title: item.title,
            url: item.url,
            thumbnailUrl: item.thumbnailUrl
        )
    }
    
    static let SampleData: PhotoObject = PhotoObject(
        albumId: 1,
        id: 1,
        title: "Sample Title",
        url: "https://via.placeholder.com/600/92c952",
        thumbnailUrl: "https://via.placeholder.com/150/92c952"
    )
}
