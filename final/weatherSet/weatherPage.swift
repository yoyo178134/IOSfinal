//
//  weatherPage.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/20.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI

struct weatherPage: View {
    @ObservedObject var countryData:CountryData = CountryData()
    @State var index = 0
    var body: some View {
        PagingView(index: $index.animation(), maxIndex: self.countryData.countries.count-1){
            ForEach(self.countryData.countries,id:\.self.id){
                (location) in
                weatherList(selectedName:location.name)
            }
        }
       
    }
}

struct weatherPage_Previews: PreviewProvider {
    static var previews: some View {
        weatherPage()
    }
}


