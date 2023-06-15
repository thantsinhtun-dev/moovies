//
//  HomeView.swift
//  Moovies
//
//  Created by Thant Sin Htun on 09/06/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel : HomeViewModel
    @State var showDetail = false
    @State var searchText = ""
    
    @State var movieId : String = ""
    let fetcher = TheMovieFetcher()
    
    
    
    @State var selectedVO : MovieVO?
    
    init(){
        
        viewModel = HomeViewModel(theMovieFetcher: fetcher)
    }
    var body: some View {
        
        
        ScrollView(showsIndicators: false){
            profileView
                .padding(.horizontal,12)
                .padding(.vertical,12)
            searchView
                .padding(.horizontal,12)
                .padding(.bottom,12)
            categoryView
                .padding(.bottom,12)
            nowPlayingView
                .padding(.bottom,12)
            popularMovieView
                .padding(.bottom,12)
            Spacer()
            
        }
        .padding(.top,10)
        .fullScreenCover(isPresented: $showDetail){
            viewModel.movieDetailView(showDetail: $showDetail, forMovieId: self.movieId, fetcher: fetcher)
        }
        .onChange(of: movieId){ value in
            print("selected Vo change")
        }
        
    }
    
    func onTapMovie(vo:MovieVO){
        
        self.movieId = String(vo.id)
        print("movie id home",movieId)
        
        if self.movieId != ""{
            showDetail = true
        }
        
    }
}

private extension HomeView {
    var profileView : some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome Joko")
                    .foregroundColor(Color.secondary)
                    .bodySmall()
                    .padding(.bottom,3)
                Text("Let's relax and watch a movie !")
                    .bodyMedium()
            }
            Spacer()
            Image("boy")
                .resizable()
                .frame(width: 50,height: 50)
                .background(Color.secondary)
                .cornerRadius(50)
            
        }
        
    }
    var searchView : some View {
        HStack {
            Image("search")
                .resizable()
                .frame(width: 20.0, height: 20.0)
                .foregroundColor(Color.colorTextGray)
            
            TextField( "", text: $searchText,
                       prompt:Text("Search").foregroundColor(Color.colorTextGray))
            .accentColor(Color.white)
            .foregroundColor(Color.colorTextGray)
        }
        .padding(.horizontal,12)
        .padding(.vertical,12)
        .background(Color.colorGray)
        .cornerRadius(25)
        
    }
    
    
    var categoryView : some View {
        VStack{
            HStack(alignment: .center){
                Text("Categories")
                    .displayMedium()
                Spacer()
                Text("View all")
                    .bodyMedium()
                    .foregroundColor(Color.primaryColor)
            }
            .padding(.horizontal,12)
            
            ScrollView(.horizontal,showsIndicators: false){
                LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 1)){
                    ForEach(Array(viewModel.genreList.enumerated()),id:\.element){ index,vo in
                        if index == 0 {
                            CategoryView(genre: vo)
                                .padding(.leading,12)
                        }else {
                            CategoryView(genre: vo)
                        }
                    }
                }
                .frame(height: 56)
            }
        }
        .onAppear{
            viewModel.loadGenreList()
        }
    }
    
    var nowPlayingView: some View {
        VStack{
            MovieListView (title: "Now Playing", onClickViewAll: {}){
                ForEach(viewModel.nowPlayingList,id:\.self){ vo in
                    MovieView(movieVO: vo)
                        .onTapGesture {
                            onTapMovie(vo: vo)
                        }
                    
                }
            }
        } .onAppear{
            viewModel.loadGetNowPlaying(page: 1)
            
        }
        .onChange(of: viewModel.nowPlayingList){ value in
            print("onchane nowPlayingList")
        }
    }
    
    var popularMovieView: some View {
        VStack{
            MovieListView (title: "Popular Movies", onClickViewAll: {}){
                ForEach(viewModel.popularMovieList,id:\.self){ vo in
                    MovieView(movieVO: vo)
                }
            }
        } .onAppear{
            viewModel.loadPopularMovies(page: 1)
            
        }
        .onChange(of: viewModel.popularMovieList){ value in
            print("onchane popularMovieList")
        }
    }
    
    
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct MovieListView <Content:View>: View {
    var title:String
    var viewAllTitle:String
    var onClickViewAll: () -> Void
    let content: () -> Content
    init(title:String,viewAllTitle:String = "View all",onClickViewAll: @escaping () -> Void,@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
        self.viewAllTitle = viewAllTitle
        self.onClickViewAll = onClickViewAll
    }
    var body: some View {
        VStack {
            MovieListViewTitle(title: title,viewAllTitle: viewAllTitle, onClickViewAll: onClickViewAll)
                .padding(.horizontal,12)
            ScrollView(.horizontal,showsIndicators: false){
                LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 1)){
                    //                    ForEach(list,id:\.self){ txt in
                    //                        MovieView()
                    //                    }
                    content()
                }
                .frame(height: 250)
            }
        }
    }
}

struct MovieListViewTitle: View {
    var title:String
    var viewAllTitle:String
    var onClickViewAll: () -> Void
    
    var body: some View {
        HStack(alignment: .center){
            Text(title)
                .displayMedium()
            Spacer()
            Text(viewAllTitle)
                .bodyMedium()
                .foregroundColor(Color.primaryColor)
                .onTapGesture {
                    onClickViewAll()
                }
        }
    }
}
//
//struct NowPlayingMovieListView : View {
//    @ObservedObject var viewModel: HomeViewModel
//    var onTapMovie: (MovieVO) -> Void
//
//    init(viewModel: HomeViewModel,onTapMovie: @escaping (MovieVO) -> Void) {
//        self.viewModel = viewModel
//        self.onTapMovie = onTapMovie
//    }
//    var body: some View {
//        VStack{
//            MovieListView (title: "Now Playing", onClickViewAll: {}){
//                ForEach(viewModel.nowPlayingList,id:\.self){ vo in
//                    MovieView(movieVO: vo)
//                        .onTapGesture {
//                            onTapMovie(vo)
//                        }
//
//                }
//            }
//        } .onAppear{
//            viewModel.loadGetNowPlaying(page: 1)
//
//        }
//        .onChange(of: viewModel.nowPlayingList){ value in
//            print("onchane nowPlayingList")
//        }
//    }
//}
//struct PopularMovieListView : View {
//    @ObservedObject var viewModel: HomeViewModel
//
//    init(viewModel: HomeViewModel) {
//        self.viewModel = viewModel
//    }
//    var body: some View {
//        VStack{
//            MovieListView (title: "Popular Movies", onClickViewAll: {}){
//                ForEach(viewModel.popularMovieList,id:\.self){ vo in
//                    MovieView(movieVO: vo)
//                }
//            }
//        } .onAppear{
//            viewModel.loadPopularMovies(page: 1)
//
//        }
//        .onChange(of: viewModel.popularMovieList){ value in
//            print("onchane popularMovieList")
//        }
//    }
//}
//
//
//
//struct CategoriesView : View {
//    @ObservedObject var viewModel: HomeViewModel
//
//    var body: some View {
//        VStack{
//            HStack(alignment: .center){
//                Text("Categories")
//                    .displayMedium()
//                Spacer()
//                Text("View all")
//                    .bodyMedium()
//                    .foregroundColor(Color.primaryColor)
//            }
//            .padding(.horizontal,12)
//
//            ScrollView(.horizontal,showsIndicators: false){
//                LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 1)){
//                    ForEach(Array(viewModel.genreList.enumerated()),id:\.element){ index,vo in
//                        if index == 0 {
//                            CategoryView(genre: vo)
//                                .padding(.leading,12)
//                        }else {
//                            CategoryView(genre: vo)
//                        }
//                    }
//                }
//                .frame(height: 56)
//            }
//        }
//        .onAppear{
//            viewModel.loadGenreList()
//        }
//    }
//}
//
//
//
//struct ProfileView : View {
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text("Welcome Joko")
//                    .foregroundColor(Color.secondary)
//                    .bodySmall()
//                    .padding(.bottom,3)
//                Text("Let's relax and watch a movie !")
//                    .bodyMedium()
//            }
//            Spacer()
//            Image("boy")
//                .resizable()
//                .frame(width: 50,height: 50)
//                .background(Color.secondary)
//                .cornerRadius(50)
//
//        }
//
//    }
//}


