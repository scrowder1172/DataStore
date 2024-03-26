//
//  PhotoDTO.swift
//  DataStore
//
//  Created by SCOTT CROWDER on 3/26/24.
//

import Foundation

struct PhotoDTO: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    
}
