//
//  LoadImageView.swift
//  CupCakes
//
//  Created by Roman on 12/24/22.
//

import SwiftUI

struct LoadExistingImage: View{
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){
            image in
            image
                .resizable()
                .scaledToFit()
        }placeholder: {
            //Color.red
            ProgressView()
        }
        .frame(width: 300, height: 300)
         
    }
}

struct LoadErrorImage: View{
    var body: some View{
        AsyncImage(url: URL( string: "this/image/doesn't/exist")){
            image in
            if let imageIn = image.image{
                imageIn
                    .resizable()
                    .scaledToFit()
            }else if image.error != nil{
                Text("There was an error loading the image")
            }else{
                ProgressView()
            }
            
        }
        .frame(width: 200, height: 200)
    }
}




    struct LoadImageView: View {
        var body: some View {
            LoadErrorImage()
        }
        
        struct LoadImageView_Previews: PreviewProvider {
            static var previews: some View {
                LoadImageView()
            }
        }
    }
