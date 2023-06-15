//
//  DetailView.swift
//  Moovies
//
//  Created by Thant Sin Htun on 09/06/2023.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var showDetail:Bool
    @ObservedObject var viewModel : DetailViewModel
    
    init(showDetail: Binding<Bool>,viewModel: DetailViewModel) {
        _showDetail = showDetail
        self.viewModel = viewModel
        
    }
    var body: some View {
        
        VStack(alignment:.leading){
            trailerView
            ScrollView(showsIndicators: false){
                VStack{
                    aboutMovie
                    
                    castListView
                }
            }
            Spacer()
            
            
        }
        .onChange(of: viewModel.movieVO){ v in
            print("moview vo change")
        }
        .ignoresSafeArea(.container,edges: .top)
    }
    
}

private extension DetailView {
    
    var trailerView : some View {
        ZStack(alignment: .top){
            
            VStack {
                if let img = viewModel.movieVO?.getPosterPath() {
                    AsyncImage(url: URL(string: img)!,content: { image in
                        image.resizable()
                        //                    .aspectRatio(contentMode: .fill)
                            .frame(height: 400)
                            .cornerRadius(10)
                    },
                               placeholder: {
                        ProgressView()
                            .frame(height: 400)
                    })
                    
                }
            }
            
            backItemView
                .padding(.top,56)
                .padding(.horizontal,24)
        }
    }
    var backItemView : some View{
        HStack(spacing:nil){
            Button(action: {
                showDetail = false
            }, label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(Color.white)
                    .padding(13)
                    .background(Color.colorSecondaryGray)
                    .cornerRadius(.infinity)
            })
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: "clock")
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(Color.white)
                    .padding(13)
                    .background(Color.colorSecondaryGray)
                    .cornerRadius(.infinity)
            })
            
        }
        
    }
    
    var aboutMovie : some View {
        VStack(alignment:.leading) {
            HStack {
                Text("95% match")
                    .displaySmall(enSize: 14)
                Text(viewModel.movieVO?.getReleaseYear() ?? "")
                    .displaySmall(enSize: 14)
                
                
                Text(viewModel.movieVO?.getRunTime() ?? "")
                    .displaySmall(enSize: 14)
                
                Text("R")
                    .displaySmall(enSize: 14)
                
                Text("HD")
                    .displaySmall(enSize: 14)
                
                
            }
            
            Text(viewModel.movieVO?.getMovieTitle() ?? "")
                .displaySmall()
                .padding(.vertical,4)
            
            Button(action: {
                
            }, label: {
                Text("Watch")
                    .foregroundColor(Color.white)
                
            })
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(Color.primaryColor)
            .cornerRadius(10)
            
            Text("Prolog")
                .displaySmall(enSize: 20)
                .padding(.bottom,10)
            Text(viewModel.movieVO?.overview ?? "")
                .titleLarge(enSize: 14)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical,16)
        .padding(.horizontal,16)
    }
    
    var castListView : some View {
        VStack(alignment: .leading){
            Text("Casts")
                .displaySmall(enSize: 20)
                .padding(.horizontal,16)
            
            ScrollView(.horizontal,showsIndicators: false){
                LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 1)){
                    ForEach(viewModel.castList,id: \.self){item in
                        CastView(castVO: item)
                            .padding(.leading,16)
                    }
                }
            }
            
        }
        
    }
    
    
}

struct TrailerView : View {
    @ObservedObject var viewModel : DetailViewModel
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.movieVO?.getPosterPath() ?? "")!,content: { image in
                image.resizable()
                //                    .aspectRatio(contentMode: .fill)
                    .frame(height: 400)
                    .cornerRadius(10)
            },
                       placeholder: {
                ProgressView()
                    .frame(height: 400)
            })
        }
    }
}


struct BackItemView : View {
    @Binding var showDetail:Bool
    
    var body: some View{
        HStack(spacing:nil){
            Button(action: {
                showDetail = false
            }, label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(Color.white)
                    .padding(13)
                    .background(Color.colorSecondaryGray)
                    .cornerRadius(.infinity)
            })
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: "clock")
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(Color.white)
                    .padding(13)
                    .background(Color.colorSecondaryGray)
                    .cornerRadius(.infinity)
            })
            
        }
        
    }
}


//struct CastListView: View {
//
//    var body: some View {
//        VStack(alignment: .leading){
//            Text("Top Cast")
//                .displaySmall(enSize: 20)
//                .padding(.horizontal,16)
//
//            ScrollView(.horizontal,showsIndicators: false){
//                LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 1)){
//                    ForEach(categories,id: \.self){_ in
//                        CastView()
//                            .padding(.leading,16)
//                    }
//                }
//            }
//
//        }
//
//    }
//}

//
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var show = true
//        DetailView(showDetail: $show)
//    }
//}
