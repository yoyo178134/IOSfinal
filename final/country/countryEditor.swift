//
//  countryEditor.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/20.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI

struct countryEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var countryData: CountryData
    @State private var selectedName = "臺北市"
    var editCountry: Country?
    var countryName = ["臺北市","新北市","桃園市","臺中市","臺南市","高雄市","基隆市","新竹縣","新竹市","苗栗縣","彰化縣","南投縣","雲林縣","嘉義縣","嘉義市","屏東縣","宜蘭縣","花蓮縣","臺東縣","澎湖縣","金門縣","連江縣"]
    var body: some View {
            Form {
                Picker(selection: $selectedName, label: Text("\(selectedName)")) {
                   ForEach(countryName, id: \.self) { (role) in
                      Text(role)
                   }
                }                
            }
            .navigationBarTitle("新增縣市")
            .navigationBarItems(trailing: Button("Save") {
                
                let country = Country(name: self.selectedName)
                
                if let editCountry = self.editCountry {
                    let index = self.countryData.countries.firstIndex {
                        $0.id == editCountry.id
                    }!
                    self.countryData.countries[index] = country
                } else {
                    self.countryData.countries.insert(country, at: 0)
                }

                
                self.presentationMode.wrappedValue.dismiss()
            })
                .onAppear {
                    
                    if let editCountry = self.editCountry {
                        self.selectedName = editCountry.name
                    }
        }
        
    }
}

struct countryEditor_Previews: PreviewProvider {
    static var previews: some View {
        countryEditor(countryData:CountryData())
    }
}
