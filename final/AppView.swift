//
//  AppView.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/17.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI
import MapKit
func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
    //1
    let locale = Locale(identifier: "zh_TW")
    let loc: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
    if #available(iOS 11.0, *) {
        CLGeocoder().reverseGeocodeLocation(loc, preferredLocale: locale) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                UserDefaults.standard.removeObject(forKey: "AppleLanguages")
                completion(nil, error)
                return
            }
            completion(placemark, nil)
        }
    }
}
func locationAddress(){
    //CLGeocoder地理編碼 經緯度轉換地址位置
    geocode(latitude: 24.12721655694024, longitude: 120.6682352929325) { placemark, error in
        guard let placemark = placemark, error == nil else { return }
        // you should always update your UI in the main thread
        DispatchQueue.main.async {
            //  update UI here
            print("address1:", placemark.thoroughfare ?? "")
            print("address2:", placemark.subThoroughfare ?? "")
            print("city:",     placemark.locality ?? "")
            print("state:",    placemark.administrativeArea ?? "")
            print("zip code:", placemark.postalCode ?? "")
            print("country:",  placemark.country ?? "")
            print("placemark",placemark)
            
        }
    }
}

struct AppView: View {
    
    var body: some View {
        TabView{
            weatherPage()
                .tabItem{
                    Image(systemName: "cloud.sun")
            }
            countryList()
                .tabItem{
                    Image(systemName: "map")
            }
            nineGAGView()
                .tabItem{
                    Image(systemName: "9.alt.square.fill")
            }
            InfoView()
                .tabItem{
                    Image(systemName:"person.circle")
            }
        }.onAppear()
        
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
