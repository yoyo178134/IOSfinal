//
//  Weather.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/17.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import Foundation

// MARK: - Weather
struct Weathersrc: Codable {
    let result: WeatherResult
}

// MARK: - WeatherResult
struct WeatherResult: Codable {
    let limit, offset, count: Int
    let sort: String
    let results: [Weather]
}

// MARK: - ResultElement
struct Weather: Codable {
    let parameterName2: String
    let parameterName1: String
    let parameterName3, parameterValue1, locationName: String
    let endTime, startTime: String
    let _id: Int
}




