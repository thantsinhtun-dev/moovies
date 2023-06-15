//
//  CategoryView.swift
//  Moovies
//
//  Created by Thant Sin Htun on 09/06/2023.
//

import SwiftUI

struct CategoryView: View {
    var genre:GenreVO;
    var body: some View {
        VStack{
            Text(genre.name)
                .bodyMedium()
                .padding(.horizontal,12)
                .padding(.vertical,12)
                .background(Color.colorGray)
                .cornerRadius(50)
        }.padding(.leading,0)
    }
}

struct CategoryView_Previews: PreviewProvider {

    static var previews: some View {
        CategoryView(genre: GenreVO(id: 1, name:  "Action"))
    }
}
