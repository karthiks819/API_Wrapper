//
//  CodableResponse.swift
//  ProjectLightning
//
//  Created by oles on 11.10.2020.
//

import Foundation

struct CodableResponse<T:Codable>: Codable {
    var currentPage: Int?
    var data: T?
}
