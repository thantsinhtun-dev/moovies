//
//  CastView.swift
//  Moovies
//
//  Created by Thant Sin Htun on 11/06/2023.
//

import SwiftUI

struct CastView: View {
    var castVO : CastVO
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: castVO.getPosterPath())!,content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
//                     .frame(maxWidth: 200, maxHeight: 200)
                    .frame(width:80,height: 80)
                    .cornerRadius(.infinity)
            },
            placeholder: {
                ProgressView()
                    .frame(width:80,height: 80)

            })
            
            Text(castVO.originalName)
                .bodyMedium(enSize: 14)
                .lineLimit(1)
                .foregroundColor(Color.white)
            
            Text(castVO.character ?? "")
                .titleLarge()
                .lineLimit(1)
                .foregroundColor(Color.gray)
        }
    }
}

