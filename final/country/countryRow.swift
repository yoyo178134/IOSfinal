//
//  countryRow.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/20.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI

struct countryRow: View {
    var country: Country
    var body: some View {
        HStack(){
            Text(country.name)
            Spacer()
        }
    }
}

struct countryRow_Previews: PreviewProvider {
    static var previews: some View {
        countryRow(country: Country(name: "臺北市"))
    }
}
