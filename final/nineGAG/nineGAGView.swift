//
//  nineGAGView.swift
//  final
//
//  Created by 郭垣佑 on 2020/6/21.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import SwiftUIPullToRefresh
import SafariServices
import AVKit

struct nineGAGView: View {
    @State private var posts = [Post]()
    @State var showSafari = false
    @State var urlString = "https://duckduckgo.com"

    func fetchAPI(){
        let url = URL(string: "https://9gag.com/v1/group-posts/group/default/type/hot")!
        
        let task = URLSession.shared.dataTask(with: url) { resultElement, response, error in
            
            
            if  let resultElement = resultElement{
                do{
                    let decoder = JSONDecoder()
                    let re = try decoder.decode(Ninegag.self, from: resultElement)
                    self.posts = re.data.posts
                }
                catch{
                    print(error)
                }
            }
            else {
                print("error")
            }
            print(self.posts)
            
        }
        
        
        task.resume()
        
    }
    var body: some View {
        RefreshableNavigationView(title: "9GAG", action:{
            self.fetchAPI()
        }){
            ForEach(self.posts, id: \.id){ item in
                VStack(alignment: .center){

                    
                    if(item.type == "Animated"){
                        PlayerView(urlString: item.images.image460sv!.url.absoluteString)
                        .scaledToFit()
                    }else{
                        KFImage(item.images.image460.url)
                        .resizable()
                        .scaledToFit()
                    }
                    Button(action: {
                        self.urlString = item.url.absoluteString
                        self.showSafari = true
                        

                    }) {
                        Text(item.title)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    }
                    .sheet(isPresented: self.$showSafari) {
                        SafariView(url:URL(string: self.urlString)!)
                    }
                    
                    
                    Divider()
                }
            }
        }
        
        
        .onAppear{
            self.fetchAPI()
        }
    }
}

struct nineGAGView_Previews: PreviewProvider {
    static var previews: some View {
        nineGAGView()
    }
}


struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}

struct PlayerView: UIViewControllerRepresentable {
    
    var urlString = ""
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = AVPlayer()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if let url = URL(string: urlString) {
            let item = AVPlayerItem(url: url)
            uiViewController.player?.replaceCurrentItem(with: item)
        }
        
    }
    
    typealias UIViewControllerType = AVPlayerViewController
    
    
}
