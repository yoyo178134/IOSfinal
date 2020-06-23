//
//  weatherList.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/17.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI

struct weatherList: View {
    @State private var weather = [Weather]()
    @State var index = 0
    @State  var selectedName:String
    @State private var selectWeather = [Weather]()

    var country = ["臺北市","新北市","桃園市","臺中市","臺南市","高雄市","基隆市","新竹縣","新竹市","苗栗縣","彰化縣","南投縣","雲林縣","嘉義縣","嘉義市","屏東縣","宜蘭縣","花蓮縣","臺東縣","澎湖縣","金門縣","連江縣"]
    func fetchAPI(countryName:String){
        let url = URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=e6831708-02b4-4ef8-98fa-4b4ce53459d9")!

        let task = URLSession.shared.dataTask(with: url) { resultElement, response, error in
            
           
            if  let resultElement = resultElement{
                do{
                    let decoder = JSONDecoder()
                    let re = try decoder.decode(Weathersrc.self, from: resultElement)
                    self.weather = re.result.results
                }
                catch{
                    print(error)
                }
                for item in self.weather {
                    if(item.locationName == countryName){
                        self.selectWeather.append(item)
                        print(self.selectWeather)
                    }
                }
            }
            else {
                print("error")
            }
            
           }
        
        
        task.resume()
        
    }
    func setPicture(item:String) -> String{
        var weatherPict = "cloud"
        switch item {
        case "15", "16", "17", "18", "21", "22", "33", "34", "35", "36", "41":
            weatherPict = "cloud.bolt.rain"
        case "1":
            weatherPict = "sun.max"
        case "25", "26", "27", "28" ,"24":
            weatherPict = "cloud.fog"
        case "8", "9", "10", "11", "12",
        "13", "14", "19", "20", "29", "30",
        "31", "32", "38", "39":
            weatherPict = "cloud.sun.rain"
        case "23", "37", "42":
            weatherPict = "snow"
        default:
            break
        }
       return weatherPict
    }
    
    func toWeek(input:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let today = dateFormatter.date(from:input)
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE"
        return dateFormatter2.string(from: today!)

    }
    
    
    var body: some View {
        VStack {
            if(self.selectWeather.count != 0){
                VStack{
                    Text(self.selectWeather[0].locationName)
                        .fontWeight(.bold)
                        .font(.system(size: 55))
                    Text(self.selectWeather[0].parameterName1)
                    Text(self.selectWeather[0].parameterName2)
                        .font(.system(size: 80))
                }
                .padding(EdgeInsets(top: 30, leading: 15, bottom: -30, trailing: 15))
            }
            List(selectWeather.indices, id: \.self) { (index)  in
                HStack {
                    if(self.selectWeather[index].endTime.substring(with:6..<10).isEmpty){
                        Text("error")
                    }else{
                        Text(self.toWeek(input: self.selectWeather[index].endTime))
                        .fixedSize()
                            .frame(width: 50,alignment: .leading)
                    }
                    Spacer()

                    if(self.selectWeather[index].endTime.substring(with: 11..<16)=="06:00"){
                        Text("白天")
                    }else{
                        Text("夜晚")
                    }
                    Spacer()
                    Image(systemName: self.setPicture(item: self.selectWeather[index].parameterValue1))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .center)
                    Spacer()
                    HStack(alignment: .lastTextBaseline){
                        Text(self.selectWeather[index].parameterName3)
                        Text("~")
                        Text(self.selectWeather[index].parameterName2)
                    }.offset(x: 0, y: -10)
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                
            }
            
            .onAppear {
                self.fetchAPI(countryName: self.selectedName)
                
            }

        }
        
    }
}


struct weatherList_Previews: PreviewProvider {
    static var previews: some View {
        weatherList( selectedName: "臺北市")
    }
}

extension String {
   func index(from: Int) -> Index {
       return self.index(startIndex, offsetBy: from)
   }

   func substring(from: Int) -> String {
       let fromIndex = index(from: from)
       return String(self[fromIndex...])
   }

   func substring(to: Int) -> String {
       let toIndex = index(from: to)
       return String(self[..<toIndex])
   }

   func substring(with r: Range<Int>) -> String {
       let startIndex = index(from: r.lowerBound)
       let endIndex = index(from: r.upperBound)
       return String(self[startIndex..<endIndex])
}
}
