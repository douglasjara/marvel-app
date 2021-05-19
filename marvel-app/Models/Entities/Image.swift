//
//  image.swift
//  marvel-app
//
//  Created by Douglas Jara Negrete on 19/5/21.
//

struct Image: Codable
{
    var path: String
    var ext: String
    
    private enum CodingKeys: String, CodingKey {
        case path =  "path"
        case ext = "extension"
    }
}
