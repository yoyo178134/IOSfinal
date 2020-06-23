//
//  countryList.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/20.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI

struct countryList: View {
    @ObservedObject var countryData = CountryData()
    @State private var showEdit = false
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            List {
                ForEach(countryData.countries) { (lover) in
                    countryRow(country: lover)
                    
                }
                .onDelete { (indexSet) in
                    if(self.countryData.countries.count != 1){
                        self.countryData.countries.remove(atOffsets: indexSet)
                    }
                    else{
                        self.showAlert = true
                    }
                }
                
                
                
            }
            .navigationBarTitle("縣市列表")
            .navigationBarItems(leading: EditButton(),trailing: Button(action: {
                self.showEdit = true
            }, label: {
                Image(systemName: "plus.circle.fill")
            }))
                .sheet(isPresented: $showEdit) {
                    NavigationView {
                        countryEditor(countryData: self.countryData)
                    }
            }
            
            
        }.alert(isPresented: $showAlert) { () -> Alert in
        return Alert(title: Text("It is the last town"))
        }
    }
}

struct countryList_Previews: PreviewProvider {
    static var previews: some View {
        countryList()
    }
}
