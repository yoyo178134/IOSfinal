//
//  File.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/20.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import Foundation
import Combine

class CountryData: ObservableObject {
    @Published var countries = [Country]()
    var cancellable: AnyCancellable?
    init() {
        if let data = UserDefaults.standard.data(forKey: "lovers") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Country].self, from: data) {
                countries = decodedData
            }
        }
        
        if(countries.isEmpty){
            countries.insert(Country(name: "臺北市"),at: 0)
        }
        
        cancellable = $countries
            .sink { (value) in
                let encoder = JSONEncoder()
                do {
                    let data = try encoder.encode(value)
                    UserDefaults.standard.set(data, forKey: "lovers")
                } catch {
                    
                }
        }
        
    }
}
