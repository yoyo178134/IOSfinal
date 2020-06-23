//
//  country.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/20.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import Foundation

struct Country: Identifiable,Codable {
    let id = UUID()
    var name: String
}
