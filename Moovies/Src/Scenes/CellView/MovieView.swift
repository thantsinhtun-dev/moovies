//
//  MovieView.swift
//  Moovies
//
//  Created by Thant Sin Htun on 09/06/2023.
//

import SwiftUI

struct MovieView: View {
    var movieVO:MovieVO
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movieVO.posterPath)")!,content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
//                     .frame(maxWidth: 200, maxHeight: 200)
                    .frame(width:150,height: 180)
                    .cornerRadius(10)
            },
            placeholder: {
                ProgressView()
                    .frame(width:150,height: 180)
            })
                .cornerRadius(20)
            Text(movieVO.originalTitle)
                .multilineTextAlignment(.center)
                .bodyMedium()
                .foregroundColor(Color.white)
                .frame(width:150,height: 40)
        }
        .padding(.leading,12)
    }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
